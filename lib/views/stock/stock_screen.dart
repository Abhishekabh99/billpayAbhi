import 'package:billpe/service/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../model/getProdcutResponse/get_prodcucts.dart';
import '../../network/get_product_api.dart';
import '../../network/profile_api.dart';
import 'search_screen.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({Key? key}) : super(key: key);

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 4, vsync: this);
  List<Product> _allStock = []; // List to hold all stock items

  @override
  void initState() {
    super.initState();

    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      // Fetch profile data to get store ID
      final String token = LocalStorage.getToken()!;
      final Map<String, dynamic> profileData =
          await ProfileApi().fetchProfileData(token);

      // Extract store ID from profile data
      // final String storeId = profileData['store_id'].toString();
      final String storeId = '3';
      // Fetch products using the obtained store ID

      final response = await GetProductApi.getProduct(storeId, token);

      setState(() {
        _allStock = response.products ?? [];
      });
    } catch (e) {
      print('Error fetching products: $e');
      // Handle error
    }
  }

  // Future<void> fetchProducts() async {
  //   try {
  //     // Replace 'storeId' and 'token' with your actual values

  //     final String storeId = '3';
  //     final String token = LocalStorage.getToken()!;
  //     final response = await GetProductApi.getProduct(storeId, token);
  //     setState(() {
  //       _allStock = response.products ?? [];
  //     });
  //   } catch (e) {
  //     print('Error fetching products: $e');
  //     // Handle error
  //   }
  // }

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
                Expanded(
                  child: IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor:
                          Colors.blue, // Change to your desired color
                    ),
                    onPressed: () {
                      HapticFeedback.selectionClick();
                      // Handle button press
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.white,
                    ),
                    onPressed: () {
                      HapticFeedback.selectionClick();
                      // Handle button press
                    },
                    child: Image.asset(
                      "assets/icons/barcode_scanner.png",
                    ),
                  ),
                ),
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
              TabBar(
                isScrollable: false,
                controller: tabController,
                labelPadding: EdgeInsets.zero,
                tabs: const [
                  Tab(
                    height: 60,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "All Stock",
                        ),
                        Text("(0)"),
                      ],
                    ),
                  ),
                  Tab(
                    height: 60,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Low Stock"),
                        Text("(0)"),
                      ],
                    ),
                  ),
                  Tab(
                    height: 60,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Most Sold"),
                        Text("(0)"),
                      ],
                    ),
                  ),
                  Tab(
                    height: 60,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Least Sold"),
                        Text("(0)"),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: TabBarView(controller: tabController, children: [
                  // All Stock Tab
                  ListView.builder(
                    itemCount: _allStock.length,
                    itemBuilder: (context, index) {
                      final product = _allStock[index];
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Image
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: product.productImage != null &&
                                        product.productImage!.isNotEmpty
                                    ? DecorationImage(
                                        image:
                                            NetworkImage(product.productImage!),
                                        fit: BoxFit.cover,
                                      )
                                    : null, // Handle empty or null image URL
                              ),
                            ),
                            SizedBox(width: 16.0),
                            // Product Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Product Name
                                  Text(
                                    product.productName ?? '',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  // MRP, Quantity, Price
                                  Text(
                                    'MRP: ${product.mrp}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'QTN: ${product.quantity}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'PRICE: \$${product.sellPrice}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Placeholder(), // Placeholder for other tabs
                  Placeholder(),
                  Placeholder(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
