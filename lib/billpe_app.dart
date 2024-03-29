import 'package:billpe/app_router.dart';
import 'package:billpe/global/app_colors.dart';
import 'package:flutter/material.dart';

class BillPeApp extends StatelessWidget {
  const BillPeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'BillPe',
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        scaffoldBackgroundColor: Colors.white,
      ),
      routerConfig: appRouter,
    );
  }
}
