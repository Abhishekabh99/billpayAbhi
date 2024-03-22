import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:billpe/views/stock/quick_add_screen.dart';
import 'package:billpe/global/app_colors.dart';
import 'package:billpe/views/stock/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../model/searchProductResponse/product.dart';

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
  }

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
                      backgroundColor: AppColors.primary,
                    ),
                    onPressed: () {
                      HapticFeedback.selectionClick();
                      showModalBottomSheet(
                        context: context,
                        showDragHandle: true,
                        enableDrag: true,
                        isScrollControlled: true,
                        useSafeArea: true,
                        builder: (context) {
                          return const QuickAddScreen();
                        },
                      );
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
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return AiBarcodeScanner(
                            onScan: (String value) {
                              debugPrint(value);
                            },
                            onDetect: (BarcodeCapture barcodeCapture) {
                              debugPrint(barcodeCapture.toString());
                            },
                          );
                        },
                      );
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
                                image: DecorationImage(
                                  image:
                                      NetworkImage(product.productImage ?? ''),
                                  fit: BoxFit.cover,
                                ),
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



//previous search button 
// Card(
//                     elevation: 4,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(15),
//                       child: TextFormField(
//                         decoration: const InputDecoration(
//                           border: InputBorder.none,
//                           fillColor: Colors.white,
//                           filled: true,
//                           prefixIcon: Icon(
//                             Icons.search,
//                             size: 18,
//                           ),
//                           hintText: "Search",
//                           hintStyle: TextStyle(
//                             fontSize: 14,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),