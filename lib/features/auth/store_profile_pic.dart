import 'dart:io';

import 'package:billpe/features/auth/auth_api.dart';
import 'package:billpe/features/home/main_router.dart';
import 'package:billpe/global/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class StoreProfilePic extends StatefulWidget {
  final String phoneNumber;
  final String storeID;
  const StoreProfilePic(
      {required this.phoneNumber, required this.storeID, super.key});

  @override
  State<StoreProfilePic> createState() => _StoreProfilePicState();
}

class _StoreProfilePicState extends State<StoreProfilePic> {
  XFile? file;
  pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (context.mounted) {
        setState(() {
          file = image;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Center(
              child: InkWell(
                onTap: () {
                  pickImage();
                },
                child: Stack(
                  children: [
                    Container(
                      width: 170,
                      height: 170,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 7,
                          color: Colors.grey.shade400,
                        ),
                        image: file != null
                            ? DecorationImage(
                                image: FileImage(
                                  File(file?.path ?? ""),
                                ),
                              )
                            : null,
                      ),
                      child: file == null
                          ? Image.asset("assets/images/store_image.png")
                          : null,
                    ),
                    const Positioned.fill(
                      top: 4,
                      right: 4,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.add,
                          size: 50,
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
            OutlinedButton(
              onPressed: pickImage,
              child: const Text(
                "Add Profile Picture",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                fixedSize: const Size(300, 50),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(14),
                  ),
                ),
              ),
              onPressed: () async {
                if (file == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please select image")));
                  return;
                }
                final result = await AuthApi.uploadStoreImage(
                    widget.phoneNumber,
                    file?.path ?? "",
                    file?.name ?? "",
                    widget.storeID);
                if (context.mounted) {
                  context.go(MainPath.main);
                }
              },
              child: const Text(
                "Save",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Skip",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
