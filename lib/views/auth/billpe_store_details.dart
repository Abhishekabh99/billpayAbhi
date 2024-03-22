import 'dart:developer';
import 'package:billpe/network/auth_api.dart';
import 'package:billpe/views/auth/model/store_category_model.dart';
import 'package:billpe/views/home/main_router.dart';
import 'package:billpe/generated/locale_keys.g.dart';
import 'package:billpe/global/app_colors.dart';
import 'package:billpe/global/location_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';

import '../../service/local_storage.dart';

class BillPeStoreDetails extends StatefulWidget {
  final String phoneNumber;
  const BillPeStoreDetails({required this.phoneNumber, super.key});
  @override
  State<BillPeStoreDetails> createState() => _BillPeStoreDetailsState();
}

class _BillPeStoreDetailsState extends State<BillPeStoreDetails> {
  final TextEditingController _storeNameController =
      TextEditingController(text: "");
  bool isGSTEnabled = false;
  final TextEditingController _storeAddressController =
      TextEditingController(text: "");
  final TextEditingController _storeOwnerNameController =
      TextEditingController(text: "");
  final TextEditingController _storeAlternateNumberController =
      TextEditingController(text: "");
  final TextEditingController _storeEmailController =
      TextEditingController(text: "");
  final TextEditingController _storeGSTController =
      TextEditingController(text: "");
  int? storeType;
  Position? position;
  PickedData? pickedLocationData;
  List<StoreCategoryModel> storeCategories = [];
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    getStoreCategory();
  }

  getStoreCategory() async {
    final categories = await AuthApi.getStoreCategories();
    if (categories.isNotEmpty) {
      if (context.mounted) {
        setState(() {
          storeCategories = categories;
        });
      }
    }
  }

  getCurrentLocation() async {
    position = await LocationService.determinePosition();
  }

  @override
  void dispose() {
    _storeNameController.dispose();
    _storeAddressController.dispose();
    _storeOwnerNameController.dispose();
    _storeAlternateNumberController.dispose();
    _storeEmailController.dispose();
    _storeGSTController.dispose();
    super.dispose();
  }

  pickLocation() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          body: FlutterLocationPicker(
            initZoom: 18.4,
            minZoomLevel: 0,
            maxZoomLevel: 18.4,
            countryFilter: "eg,in",
            trackMyPosition: false,
            initPosition: LatLong(
              position?.latitude ?? 0,
              position?.longitude ?? 0,
            ),
            onPicked: (pickedData) {
              pickedLocationData = pickedData;
              log("${pickedLocationData?.addressData}");
              if (context.mounted) {
                setState(() {
                  _storeAddressController.text = pickedData.address;
                });
              }
              Navigator.pop(context);
            },
          ),
        );
      },
    ));
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
        title: Text(
          LocaleKeys.storeDetailsStr,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome!",
                      style: TextStyle(fontSize: 28),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      "Store Name*",
                      style: TextStyle(fontSize: 13),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _storeNameController,
                      decoration: InputDecoration(
                        labelText: "",
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        isDense: true,
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
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 100,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Store Category*",
                                  style: TextStyle(fontSize: 13),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SizedBox(
                                  child: DropdownButtonFormField(
                                    items: storeCategories
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e.name ?? ""),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      if (context.mounted && value != null) {
                                        setState(() {
                                          storeType = value.id!;
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                      isDense: true,
                                      fillColor: Colors.grey.shade200,
                                      filled: true,
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
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Whatsapp Number*",
                                  style: TextStyle(fontSize: 13),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SizedBox(
                                  child: TextFormField(
                                    enabled: false,
                                    initialValue: widget.phoneNumber,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      hintText: widget.phoneNumber,
                                      fillColor: Colors.grey.shade300,
                                      filled: true,
                                      isDense: true,
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(30),
                                        ),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(30),
                                        ),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(30),
                                        ),
                                      ),
                                      prefixIcon: const Padding(
                                        padding: EdgeInsets.only(
                                          left: 8.0,
                                          right: 10,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text("+91"),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            SizedBox(
                                              height: 18,
                                              child: VerticalDivider(
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    keyboardType: TextInputType.phone,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      "Store Address*",
                      style: TextStyle(fontSize: 13),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _storeAddressController,
                      enabled: true,
                      onTap: pickLocation,
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: pickLocation,
                          child: const Icon(Icons.location_searching_rounded),
                        ),
                        labelText: "",
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        isDense: true,
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
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Alternate Phone Number",
                                style: TextStyle(fontSize: 13),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              TextFormField(
                                controller: _storeAlternateNumberController,
                                decoration: InputDecoration(
                                  labelText: "",
                                  fillColor: Colors.grey.shade200,
                                  filled: true,
                                  isDense: true,
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
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "E-mail Address",
                                style: TextStyle(fontSize: 13),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              TextFormField(
                                controller: _storeEmailController,
                                decoration: InputDecoration(
                                  labelText: "",
                                  fillColor: Colors.grey.shade200,
                                  filled: true,
                                  isDense: true,
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
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      "Owner's full Name*",
                      style: TextStyle(fontSize: 13),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _storeOwnerNameController,
                      decoration: InputDecoration(
                        labelText: "",
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        isDense: true,
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
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Do you have GST?",
                          style: TextStyle(fontSize: 13),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Switch(
                          value: isGSTEnabled,
                          onChanged: (value) {
                            if (context.mounted) {
                              setState(() {
                                isGSTEnabled = value;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: isGSTEnabled ? 8 : 0,
                    ),
                    isGSTEnabled
                        ? TextFormField(
                            controller: _storeGSTController,
                            decoration: InputDecoration(
                              labelText: "",
                              fillColor: Colors.grey.shade200,
                              filled: true,
                              isDense: true,
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
                          )
                        : const SizedBox(),
                  ],
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            fixedSize: const Size(280, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () async {
                            onSaveButtonClick();
                          },
                          child: const Text(
                            "Save",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  onSaveButtonClick() async {
    if (_storeNameController.text.trim().isEmpty ||
        _storeNameController.text.trim().length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Store Name is required"),
        ),
      );
      return;
    }
    if (storeType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Store Type is required"),
        ),
      );
      return;
    }
    if (_storeAddressController.text.trim().isEmpty ||
        _storeAddressController.text.trim().length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Store Address is required"),
        ),
      );
      return;
    }
    if (_storeAlternateNumberController.text.trim().isNotEmpty &&
        _storeAlternateNumberController.text.trim().length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid phone number"),
        ),
      );
      return;
    }
    if (_storeEmailController.text.trim().isNotEmpty &&
        !_storeEmailController.text.trim().contains("@")) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid Email ID"),
        ),
      );
      return;
    }
    if (_storeOwnerNameController.text.trim().isEmpty ||
        _storeOwnerNameController.text.trim().length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Store Owner name is required"),
        ),
      );
      return;
    }

    // final (store, result) = await AuthApi.addUser(
    // storeName: _storeNameController.text,
    // email: _storeEmailController.text,
    // storeType: storeType!,
    // whatsappNumber: widget.phoneNumber,
    // gstNumber: _storeGSTController.text,
    // address: _storeAddressController.text,
    // latitude: pickedLocationData?.latLong.latitude.toString() ?? "",
    // longitude: pickedLocationData?.latLong.longitude.toString() ?? "",
    // pincode: pickedLocationData?.addressData["postcode"] ?? "",
    // city: pickedLocationData?.addressData["city"] ?? "",
    // ownerName: _storeOwnerNameController.text,
    // );
    // if (store != null) {
    //   if (context.mounted) {
    //     context.go(MainPath.main);
    //   }
    // }
    final response = await AuthApi.addUser(
      storeName: _storeNameController.text,
      email: _storeEmailController.text,
      storeType: storeType!,
      whatsappNumber: widget.phoneNumber,
      gstNumber: _storeGSTController.text,
      address: _storeAddressController.text,
      latitude: pickedLocationData?.latLong.latitude.toString() ?? "",
      longitude: pickedLocationData?.latLong.longitude.toString() ?? "",
      pincode: pickedLocationData?.addressData["postcode"] ?? "",
      city: pickedLocationData?.addressData["city"] ?? "",
      ownerName: _storeOwnerNameController.text,
    );
    if (response?.success == true) {
      if (response!.token != null && response.token!.isNotEmpty) {
        await LocalStorage.setToken(response.token!);
        context.go(MainPath.main);
      }
    } else {
      print("Something went wrong");
    }
  }
}
