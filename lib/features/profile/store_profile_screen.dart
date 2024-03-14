import 'package:billpe/features/auth/store_local_db.dart';
import 'package:billpe/features/auth/store_profile_pic.dart';
import 'package:billpe/features/auth/user_local_db.dart';
import 'package:billpe/global/app_colors.dart';
import 'package:flutter/material.dart';

class StoreProfileScreen extends StatefulWidget {
  const StoreProfileScreen({super.key});

  @override
  State<StoreProfileScreen> createState() => _StoreProfileScreenState();
}

class _StoreProfileScreenState extends State<StoreProfileScreen> {
  final user = UserLocalStorage.getUserData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        backgroundColor: AppColors.primary,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                final user = UserLocalStorage.getUserData();
                final store = StoreLocalStorage.getStoreData();
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return StoreProfilePic(
                        phoneNumber: user?.whatsappNo ?? "",
                        storeID: store?.id.toString() ?? "");
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
            const SizedBox(
              height: 16,
            ),
            Text(
              user?.name ?? "",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              "+91-${user?.whatsappNo ?? ""}",
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 3,
                fixedSize: const Size(300, 40),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shadowColor: const Color(0xff009db3),
                shape: const RoundedRectangleBorder(
                  side: BorderSide(
                    color: Color(0xff009db3),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
              ),
              onPressed: () {},
              child: const Text("Free Trial"),
            )
          ],
        ),
      ),
    );
  }
}
