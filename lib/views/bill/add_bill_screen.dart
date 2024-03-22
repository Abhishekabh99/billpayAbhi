import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:billpe/views/bill/add_bill_product_screen.dart';
import 'package:billpe/views/bill/components/new_bill_component.dart';
import 'package:billpe/global/app_colors.dart';
import 'package:billpe/package/toggle_tab.dart';
import 'package:flutter/material.dart';

class AddBillScreen extends StatelessWidget {
  const AddBillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   surfaceTintColor: Colors.white,
      //   shadowColor: Colors.black,
      //   elevation: 2,
      //   leading: InkWell(
      //     onTap: () {
      //       context.pop();
      //     },
      //     child: const Icon(
      //       Icons.arrow_back_ios_new_outlined,
      //     ),
      //   ),
      //   title: const Text("Add Bill"),
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const NewBillComponent(),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
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
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          showDragHandle: true,
                          enableDrag: true,
                          isScrollControlled: true,
                          useSafeArea: true,
                          builder: (context) {
                            return const AddProductinBillScreen();
                          },
                        );
                      },
                      child: Image.asset(
                        "assets/icons/add.png",
                        width: 47,
                        height: 47,
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        surfaceTintColor: Colors.white,
                      ),
                      onPressed: () {
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
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      final TextEditingController customerNameController =
                          TextEditingController();
                      final TextEditingController mobileNumberController =
                          TextEditingController();
                      final TextEditingController addressController =
                          TextEditingController();
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                      color: Colors.black, width: 2),
                                ),
                                clipBehavior: Clip.none,
                                backgroundColor: Colors.white,
                                surfaceTintColor: Colors.white,
                                actions: [
                                  Center(
                                    child: IconButton.filled(
                                      style: IconButton.styleFrom(
                                          backgroundColor:
                                              AppColors.lightOrange),
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                                title: const Center(
                                    child: Text(
                                  "Add Customer",
                                  style: TextStyle(fontSize: 18),
                                )),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Name of the customer*",
                                          style: TextStyle(),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        TextFormField(
                                          controller: customerNameController,
                                          decoration: InputDecoration(
                                            labelText: "",
                                            fillColor: Colors.white,
                                            filled: true,
                                            isDense: true,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: const BorderSide(
                                                color: AppColors.primary,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Mobile number*",
                                          style: TextStyle(),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        TextFormField(
                                          controller: mobileNumberController,
                                          decoration: InputDecoration(
                                            labelText: "",
                                            fillColor: Colors.white,
                                            filled: true,
                                            isDense: true,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: const BorderSide(
                                                color: AppColors.primary,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Address*",
                                          style: TextStyle(),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        TextFormField(
                                          controller: addressController,
                                          decoration: InputDecoration(
                                            labelText: "",
                                            fillColor: Colors.white,
                                            filled: true,
                                            isDense: true,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: const BorderSide(
                                                color: AppColors.primary,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    label: const Text(
                      "Customer",
                      style: TextStyle(
                        color: AppColors.lightOrange,
                      ),
                    ),
                    icon: const Icon(
                      Icons.add,
                      color: AppColors.lightOrange,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.only(
                                left: 6,
                                right: 6,
                              ),
                              visualDensity: VisualDensity.compact,
                            ),
                            onPressed: () {
                              final TextEditingController discountController =
                                  TextEditingController();
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                      builder: (context, setState) {
                                    return Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: const BorderSide(
                                                color: Colors.black, width: 2),
                                          ),
                                          clipBehavior: Clip.none,
                                          backgroundColor: Colors.white,
                                          surfaceTintColor: Colors.white,
                                          actions: [
                                            Center(
                                              child: IconButton.filled(
                                                style: IconButton.styleFrom(
                                                    backgroundColor:
                                                        AppColors.lightOrange),
                                                onPressed: () {},
                                                icon: const Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                          title: const Center(
                                              child: Text(
                                            "Add Discount",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Text("Total Bill: ₹110"),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              const Text(
                                                "Sell Price: ₹90",
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Stack(
                                                clipBehavior: Clip.none,
                                                children: [
                                                  SizedBox(
                                                    width: 160,
                                                    child: TextFormField(
                                                      controller:
                                                          discountController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: "",
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        isDense: true,
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          borderSide:
                                                              const BorderSide(
                                                            color: AppColors
                                                                .primary,
                                                          ),
                                                        ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    right: -40,
                                                    height: 30,
                                                    top: 15,
                                                    width: 80,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child:
                                                          AppinioAnimatedToggleTab(
                                                        setState: setState,
                                                        callback: (int i) {},
                                                        tabTexts: const [
                                                          '₹',
                                                          '%',
                                                        ],
                                                        outerWidths: const [
                                                          38,
                                                          38
                                                        ],
                                                        height: 30,
                                                        width: 80,
                                                        boxDecoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .transparent,
                                                          border: Border.all(
                                                              width: 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                        ),
                                                        animatedBoxDecoration:
                                                            BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: const Color(
                                                                      0xFFc3d2db)
                                                                  .withOpacity(
                                                                      0.1),
                                                              spreadRadius: 1,
                                                              blurRadius: 5,
                                                              offset:
                                                                  const Offset(
                                                                      2, 2),
                                                            ),
                                                          ],
                                                          color: Colors.white,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(30),
                                                          ),
                                                          border: Border.all(
                                                            color: Colors.grey,
                                                            width: 1,
                                                          ),
                                                        ),
                                                        activeStyle:
                                                            const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                        ),
                                                        inactiveStyle:
                                                            const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                                },
                              );
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Colors.black,
                                  size: 14,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  "Discount",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: DropdownButtonFormField(
                              value: "Cash",
                              items: ["Cash", "UPI", "Lend", "Other"]
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ))
                                  .toList(),
                              onChanged: (value) {},
                              padding: const EdgeInsets.only(
                                left: 2,
                                right: 2,
                              ),
                              isDense: true,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.black),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.only(
                                  top: 4,
                                  bottom: 4,
                                  left: 10,
                                  right: 10,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                    color: AppColors.primary,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          AppinioAnimatedToggleTab(
                            callback: (int i) {},
                            tabTexts: const [
                              'Retail',
                              'Wholesale',
                            ],
                            outerWidths: const [60, 80],
                            height: 30,
                            width: 140,
                            boxDecoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            animatedBoxDecoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xFFc3d2db).withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(2, 2),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(30),
                              ),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            activeStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                            inactiveStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Items: 01"),
                          const Text("Total: ₹110"),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              fixedSize: const Size(
                                150,
                                60,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {},
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Create Bill",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.white,
                                  size: 18,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
