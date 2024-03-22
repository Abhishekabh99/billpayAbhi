import 'package:flutter/material.dart';
import 'package:billpe/model/searchProductResponse/product.dart';
import 'package:billpe/service/local_storage.dart';
import 'package:billpe/network/search_product_api.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();

  List<Product> _suggestions = []; // List to hold search suggestions
  List<Product> _selectedItems = []; // List to hold selected items
  final String? _token = LocalStorage.getToken();
  final int _storeId = 2; // Assuming storeId is 2

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onChanged: (value) {
            // Fetch suggestions as the user types
            _fetchSuggestions(value);
          },
          decoration: InputDecoration(
            hintText: 'Search...',
            prefixIcon: Icon(Icons.search), // Search icon
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSelectedItems(), // Widget to display selected items
          Expanded(
            child:
                _buildSuggestionsList(), // Widget to display search suggestions
          ),
        ],
      ),
    );
  }

  void _fetchSuggestions(String query) async {
    try {
      final response =
          await SearchProductApi().fetchProducts(query, _storeId, _token!);
      if (response.products != null) {
        setState(() {
          _suggestions = response.products!;
        });
      } else {
        setState(() {
          _suggestions = []; // or any other default value
        });
      }
    } catch (e) {
      print('Error fetching suggestions: $e');
      // Handle error appropriately
    }
  }

  Widget _buildSelectedItems() {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _selectedItems.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Chip(
              label: Text(_selectedItems[index].productName ?? ''),
              onDeleted: () {
                setState(() {
                  _selectedItems.removeAt(index);
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildSuggestionsList() {
    return ListView.separated(
      itemCount: _suggestions.length,
      separatorBuilder: (context, index) => Divider(color: Colors.grey),
      itemBuilder: (context, index) {
        final product = _suggestions[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(product.productImage ?? ""),
          ),
          title: Text(product.productName ?? ''),
          subtitle: Text('Quantity: ${product.quantity}'),
          trailing: Text(
            '\$${product.sellPrice}',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            // Pass the selected product back to the StockScreen
            Navigator.pop(context, product);
          },
        );
      },
    );
  }
}

class StockScreen extends StatefulWidget {
  const StockScreen({Key? key}) : super(key: key);

  @override
  _StockScreenState createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 4, vsync: this);

  List<Product> _allStock = []; // List to hold all stock items

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        title: const Text(
          "Stock",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      extendBody: true,
      bottomSheet: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchScreen()),
                      ).then((selectedProduct) {
                        if (selectedProduct != null) {
                          setState(() {
                            _allStock.add(selectedProduct as Product);
                          });
                        }
                      });
                    },
                    icon: Icon(Icons.search),
                    label: Text('Search'),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                // Other buttons...
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Other widgets...
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    // All Stock Tab
                    ListView.builder(
                      itemCount: _allStock.length,
                      itemBuilder: (context, index) {
                        final product = _allStock[index];
                        return ListTile(
                          title: Text(product.productName ?? ''),
                          subtitle: Text('Quantity: ${product.quantity}'),
                          // Add more details as needed
                        );
                      },
                    ),
                    // Other tabs...
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
