import 'package:billpe/billpe_app.dart';
import 'package:billpe/global/prefs.dart';
import 'package:billpe/initial_code_run.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  InitialCodeRun.initializeImagePicker();
  await Prefs.init();
  runApp(const ProviderScope(child: BillPeApp()));
}
