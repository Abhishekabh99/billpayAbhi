import 'package:billpe/features/auth/auth_api.dart';
import 'package:billpe/features/auth/auth_router.dart';
import 'package:billpe/global/app_colors.dart';
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
        title: const Text(
          "Login/Signup",
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
                            const Text("Enter phone Number"),
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
                // const SizedBox(
                //   height: 10,
                // ),
                // const Row(
                //   children: [
                //     Expanded(
                //       child: Padding(
                //         padding: EdgeInsets.only(
                //           left: 20,
                //           right: 10,
                //         ),
                //         child: Divider(
                //           color: Colors.black,
                //         ),
                //       ),
                //     ),
                //     Text("OR"),
                //     Expanded(
                //       child: Padding(
                //         padding: EdgeInsets.only(
                //           left: 10,
                //           right: 20,
                //         ),
                //         child: Divider(
                //           color: Colors.black,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(20.0),
                //   child: ElevatedButton.icon(
                //     style: ElevatedButton.styleFrom(
                //       fixedSize: const Size(double.infinity, 50),
                //       backgroundColor: const Color(0xff1bd741),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(30),
                //       ),
                //     ),
                //     onPressed: () {
                //       // startOtpless();
                //     },
                //     icon: SizedBox(
                //       width: 30,
                //       height: 30,
                //       child: Image.network(
                //           "https://img.icons8.com/ios/100/FFFFFF/whatsapp--v1.png"),
                //     ),
                //     label: const Text(
                //       "Continue with Whatsapp",
                //       style: TextStyle(
                //         color: Colors.white,
                //       ),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 30,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
