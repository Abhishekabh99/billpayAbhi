import 'package:billpe/features/home/components/home_grid_component.dart';
import 'package:billpe/features/home/components/online_store_component.dart';
import 'package:billpe/features/home/components/stock_notification_component.dart';
import 'package:billpe/features/home/components/store_new_bill_component.dart';
import 'package:billpe/features/home/components/top_home_bar_component.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopHomeBarComponent(),
                SizedBox(
                  height: 16,
                ),
                StoreNewBillComponent(),
                SizedBox(
                  height: 16,
                ),
                Divider(
                  color: Colors.grey,
                  height: 16,
                ),
                SizedBox(
                  height: 16,
                ),
                StockNotificationComponent(),
                SizedBox(
                  height: 16,
                ),
                HomeGridComponent(),
                SizedBox(
                  height: 16,
                ),
                OnlineStoreComponent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
