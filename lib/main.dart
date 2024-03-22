import 'package:billpe/billpe_app.dart';
import 'package:billpe/global/prefs.dart';
import 'package:billpe/initial_code_run.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  InitialCodeRun.initializeImagePicker();
  await Prefs.init();

  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('hi', 'IN')],
      path: 'assets/translations', // Path to your tran('hi'slations directory
      fallbackLocale: Locale('en', 'US'),
      child: const ProviderScope(child: BillPeApp()),
    ),
  );
}
