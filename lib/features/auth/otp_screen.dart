import 'dart:async';

import 'package:billpe/features/auth/auth_api.dart';
import 'package:billpe/features/auth/auth_router.dart';
import 'package:billpe/features/auth/store_local_db.dart';
import 'package:billpe/features/home/main_router.dart';
import 'package:billpe/global/app_colors.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({required this.phoneNumber, super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpPinFieldController = GlobalKey<OtpPinFieldState>();
  int start = 59;
  late Timer timer;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);

    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          timer.cancel();
        } else {
          start--;
          setState(() {});
        }
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
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
          "OTP Verification",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "We’ve sent a verification code to",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  "+91-${widget.phoneNumber}",
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                OtpPinField(
                  key: _otpPinFieldController,
                  autoFillEnable: false,
                  textInputAction: TextInputAction.done,
                  onSubmit: (text) {},
                  onChange: (text) {},
                  onCodeChanged: (code) {},
                  otpPinFieldStyle: OtpPinFieldStyle(
                    defaultFieldBorderColor: Colors.white,
                    activeFieldBorderColor: Colors.black,
                    defaultFieldBackgroundColor: Colors.grey.shade200,
                    activeFieldBackgroundColor: Colors.grey.shade200,
                    filledFieldBackgroundColor: Colors.grey.shade200,
                    filledFieldBorderColor: Colors.grey.shade200,
                  ),
                  maxLength: 6,
                  showCursor: true,
                  cursorColor: AppColors.primary,
                  showCustomKeyboard: false,
                  showDefaultKeyboard: true,
                  cursorWidth: 2,
                  fieldWidth: 42.81,
                  fieldHeight: 45.67,
                  mainAxisAlignment: MainAxisAlignment.center,
                  otpPinFieldDecoration:
                      OtpPinFieldDecoration.defaultPinBoxDecoration,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Didn't receive OTP?",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Center(
                      heightFactor: 0.5,
                      child: TextButton(
                        onPressed: start == 0
                            ? () async {
                                AuthApi.sendOtp(widget.phoneNumber);
                                start = 59;
                                startTimer();
                              }
                            : () {},
                        child: Text(
                          start == 0
                              ? "Resend OTP"
                              : "Resend OTP in $start seconds",
                          style: TextStyle(
                            color: start == 0 ? AppColors.primary : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 120,
                ),
                Row(
                  children: [
                    Checkbox(
                      visualDensity: VisualDensity.compact,
                      value: true,
                      onChanged: (value) {},
                    ),
                    const Expanded(
                      child: Text(
                        "By verifying I agree to terms and conditions of BillPe",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      fixedSize: const Size(300, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () async {
                      if (_otpPinFieldController.currentState?.text.length !=
                          6) {
                        CherryToast.warning(
                          toastPosition: Position.bottom,
                          title: const Text(
                            "Invalid OTP",
                            style: TextStyle(color: Colors.black),
                          ),
                        ).show(context);
                        return;
                      }
                      final (user, isSuccess) = await AuthApi.verifyOTP(
                          widget.phoneNumber,
                          _otpPinFieldController.currentState?.text ?? "");
                      if (!isSuccess) {
                        if (context.mounted) {
                          CherryToast.warning(
                            toastPosition: Position.bottom,
                            title: const Text(
                              "Invalid OTP",
                              style: TextStyle(color: Colors.black),
                            ),
                          ).show(context);
                        }
                        return;
                      }
                      if (context.mounted) {
                        if (user?.image?.trim().isNotEmpty ?? false) {
                          context.go(MainPath.main);
                        } else {
                          final store = StoreLocalStorage.getStoreData();
                          if (store != null &&
                              (store.shopName?.isNotEmpty ?? false)) {
                            context.push(AuthPath.storeProfilePic, extra: {
                              "phoneNumber": widget.phoneNumber,
                              "storeID": store.id?.toString() ?? "",
                            });
                          } else {
                            context.push(AuthPath.billPeStoreDetails, extra: {
                              "phoneNumber": widget.phoneNumber,
                            });
                          }
                        }
                      }
                    },
                    child: const Text(
                      "Verify",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
