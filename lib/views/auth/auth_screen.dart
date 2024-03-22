import 'package:billpe/network/auth_api.dart';
import 'package:billpe/views/auth/auth_router.dart';
import 'package:billpe/generated/locale_keys.g.dart';
import 'package:billpe/global/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black,
        title: Text(
          LocaleKeys.loginSignUpStr, //login app bar text chnage to english
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFF2F2F2),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Image.asset(
                  "assets/images/billpe.png",
                  height: 50,
                ),
                const Text("Billing hua Aasan"),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(LocaleKeys.enterPhoneNumberStr
                                .tr()), // enter you number text change to english
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _phoneNumberController,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                hintText: "Enter your phone number",
                                fillColor: Colors.grey.shade300,
                                filled: true,
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
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
                              onFieldSubmitted: (value) async {
                                if (_phoneNumberController.text.length != 10) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "Please enter a valid phone number"),
                                    ),
                                  );
                                  return;
                                }
                                AuthApi.sendOtp(value);
                                if (context.mounted) {
                                  context.push(AuthPath.verifyOTP, extra: {
                                    "phoneNumber": value,
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
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
                    if (_phoneNumberController.text.length != 10) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter a valid phone number"),
                        ),
                      );
                      return;
                    }
                    AuthApi.sendOtp(_phoneNumberController.text);
                    if (context.mounted) {
                      // otplessFlutterPlugin.signInCompleted();
                      context.push(AuthPath.verifyOTP, extra: {
                        "phoneNumber": _phoneNumberController.text,
                      });
                    }
                  },
                  child: const Text(
                    "Get OTP on Whatsapp",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
