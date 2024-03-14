import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:billpe/features/stock/quick_add_screen.dart';
import 'package:billpe/global/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen>
    with TickerProviderStateMixin {
  late TabController tabController = TabController(length: 4, vsync: this);
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
            context.pop();
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
                    child: Card(
                      elevation: 4,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: Icon(
                              Icons.search,
                              size: 18,
                            ),
                            hintText: "Search",
                            hintStyle: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    )),
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
                          "Low Stock",
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
                        Text("All Stock"),
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
                child: TabBarView(controller: tabController, children: const [
                  SizedBox(
                    width: 10,
                    height: 10,
                  ),
                  SizedBox(
                    width: 10,
                    height: 10,
                  ),
                  SizedBox(
                    width: 10,
                    height: 10,
                  ),
                  SizedBox(
                    width: 10,
                    height: 10,
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
