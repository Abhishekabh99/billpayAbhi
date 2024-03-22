import 'package:billpe/views/auth/auth_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChooseLanguageScreen extends StatefulWidget {
  final String phoneNumber;
  const ChooseLanguageScreen({super.key, required this.phoneNumber});

  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('choose_language_title'.tr()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<Locale>(
              value: context.locale,
              items: const [
                DropdownMenuItem(
                  child: Text('English'),
                  value: Locale('en', 'US'),
                ),
                DropdownMenuItem(
                  child: Text('हिंदी'),
                  value: Locale('hi', 'IN'),
                ),
                // Add more DropdownMenuItem for other languages
              ],
              onChanged: (Locale? newLocale) {
                context.setLocale(newLocale!);
              },
            ),
            const SizedBox(
                height:
                    20), // Add some space between the dropdown and the button
            ElevatedButton(
              onPressed: () {
                context.push(AuthPath.billPeStoreDetails, extra: {
                  "phoneNumber": widget.phoneNumber,
                });
              },
              child: Text('Next'.tr()), // Use .tr() for localization
            ),
          ],
        ),
      ),
    );
  }
}
