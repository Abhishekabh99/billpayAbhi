import 'package:billpe/app_router.dart';
import 'package:billpe/views/profile/store_profile_pic.dart';
import 'package:billpe/global/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../controllers/profile_controller.dart';
import '../../service/local_storage.dart';
import '../../model/profileResponse/store.dart';
import '../../model/profileResponse/user.dart';
import '../../network/auth_api.dart';
import '../auth/model/store_category_model.dart';

class StoreProfileScreen extends StatefulWidget {
  const StoreProfileScreen({super.key});

  @override
  State<StoreProfileScreen> createState() => _StoreProfileScreenState();
}

class _StoreProfileScreenState extends State<StoreProfileScreen> {
  late Map<String, dynamic> responseData;
  bool isLoading = true;
  List<StoreCategoryModel> storeCategories = [];

  // final user = UserLocalStorage.getUserData();
  // final store = StoreLocalStorage.getStoreData();
  String? categoryName;
  final ProfileController _profileController = ProfileController();
  User? _user;
  Store? _store;
  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    try {
      final token = LocalStorage.getToken()!;
      final data = await _profileController.fetchProfileData(token);

      setState(() {
        _user = _profileController.parseUserData(data);
        _store = _profileController.parseStoreData(data);
      });
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            context.pop();
          },
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Expanded(child: body(context)),
            footer(),
            const SizedBox(
              height: 5,
            ),
          ]),
        ),
      ),
    );
  }

//body
  Column body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                // final user = UserLocalStorage.getUserData();
                // final store = StoreLocalStorage.getStoreData();
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return StoreProfilePic(
                        phoneNumber: _user?.whatsappNo ?? "",
                        storeID: _store?.id.toString() ?? "");
                  },
                ));
              },
              child: Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300,
                      ),
                    ),
                    Positioned.fill(
                      bottom: -5,
                      left: -10,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Add this line
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly, // Add this line
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        _user?.name ?? "",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        categoryName ?? "",
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        "+91-${_user?.whatsappNo ?? ""}",
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
              width: 85,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  surfaceTintColor: Colors.white,
                  side: const BorderSide(color: Colors.black),
                ),
                onPressed: () {},
                icon: const Icon(
                  Icons.edit,
                  size: 14,
                  color: Colors.black,
                ),
                label: const Text(
                  "Edit",
                  style: TextStyle(fontSize: 10, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              // Your onPressed callback function here
              print(_store?.id);
              Future.delayed(Duration(seconds: 3))
                  .then((value) => print(token));
            },
            style: ElevatedButton.styleFrom(
              surfaceTintColor: Colors.white,
              elevation: 3, // Elevation of the button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0), // Border radius
                side: const BorderSide(
                    color: Color(0xff009DB3),
                    width: 2), // Border color and width
              ),
              padding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 30), // Button padding
            ),
            child: const Text(
              'Free Trial', // Text inside the button
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ), // Text color
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black), // Border color
            borderRadius: BorderRadius.circular(10.0), // Border radius
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Address',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            _store?.address ?? '',
                            style: const TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'GST number',
                            style: TextStyle(
                                color: AppColors.primary, fontSize: 10),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            _store?.gst ?? "",
                            style: const TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Personal details',
                  style: TextStyle(color: AppColors.primary, fontSize: 10),
                ),
                const SizedBox(
                  height: 5,
                ),
                customRow('Name :', _store?.ownerName ?? ""),
                const SizedBox(height: 5),
                customRow('Email :', _user?.email ?? ""),
                const SizedBox(height: 5),
                customRow('Mobile no :', _user?.whatsappNo ?? ""),
                const SizedBox(height: 5),
                customRow('Address :', '')
              ],
            ),
          ), // Add your child widget here
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          child: ElevatedButton(
            onPressed: () {
              // Your onPressed callback function here
            },
            style: ElevatedButton.styleFrom(
              surfaceTintColor: Colors.white,
              elevation: 3, // Elevation of the button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0), // Border radius
                side: const BorderSide(
                    color: Colors.black, width: 1), // Border color and width
              ),
              padding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 30), // Button padding
            ),
            child: const Text(
              'Change Laungauge', // Text inside the button
              style: TextStyle(color: Colors.black, fontSize: 12), // Text color
            ),
          ),
        ),
      ],
    );
  }

  Column footer() {
    return Column(
      children: [
        Center(
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  surfaceTintColor: Colors.grey,
                ),
                onPressed: () {
                  print(_store!.id);
                },
                icon: const Icon(Icons.add),
                label: const Text(
                  "Add another store",
                  style: TextStyle(color: Colors.black),
                )),
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Terms of use',
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.blue,
                decorationColor: Colors.blue,
              ),
            ),
            Text(
              'Privacy policy',
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.blue,
                decorationColor: Colors.blue,
              ),
            ),
            Text(
              'contact us',
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
                decorationColor: Colors.blue,
              ),
            )
          ],
        ),
      ],
    );
  }

// API function for getModule API from authAPI
  getStoreCategory() async {
    final List<StoreCategoryModel> categories =
        await AuthApi.getStoreCategories();
    if (categories.isNotEmpty) {
      print("category empty nhi hai");
      // final store = StoreLocalStorage.getStoreData();
      if (_store != null) {
        print("store null nhi hai");
        print(_store?.toJson());
        final category =
            categories.firstWhereOrNull((e) => e.id == _store?.moduleId);
        if (category != null && context.mounted) {
          print("category null nhi hai context mounted");
          setState(() {
            categoryName = category.name;
          });
        }
      } else {
        print("store null hai");
      }
    }
  }

  Widget customRow(String labelText, String valueText) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Text(
            labelText,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 18,
          child: Text(
            valueText,
            style: const TextStyle(fontSize: 10),
          ),
        ),
      ],
    );
  }
}
