import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeGridComponent extends StatefulWidget {
  const HomeGridComponent({super.key});

  @override
  State<HomeGridComponent> createState() => _HomeGridComponentState();
}

class _HomeGridComponentState extends State<HomeGridComponent> {
  List<HomeGridModel> homeGridList = [
    HomeGridModel(
        balance: "₹ 89,900",
        iconPath: "assets/icons/sales.png",
        title: "Today's Sales"),
    HomeGridModel(
        balance: "₹ 560",
        iconPath: "assets/icons/wallet.png",
        title: "Total Billing"),
    HomeGridModel(
        balance: "₹ 72,500",
        iconPath: "assets/icons/qr_code.png",
        title: "UPI Collected"),
    HomeGridModel(
        balance: "₹ 15,000",
        iconPath: "assets/icons/payments.png",
        title: "Cash Collected"),
  ];
  bool isMoneyVisible = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  if (context.mounted) {
                    setState(() {
                      isMoneyVisible = !isMoneyVisible;
                    });
                  }
                },
                child: isMoneyVisible
                    ? const Icon(
                        Icons.visibility_outlined,
                        size: 28,
                      )
                    : const Icon(
                        Icons.visibility_off_outlined,
                        size: 28,
                      ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: homeGridList.length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final homeGrid = homeGridList[index];
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      HapticFeedback.selectionClick();
                    },
                    child: Card(
                      color: Colors.white,
                      surfaceTintColor: Colors.white,
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: Image.asset(homeGrid.iconPath),
                            ),
                            SizedBox(
                              height: isMoneyVisible ? 8 : 0,
                            ),
                            isMoneyVisible
                                ? Center(
                                    child: Text(homeGrid.balance),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Center(
                    child: Text(homeGrid.title),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class HomeGridModel {
  final String iconPath;
  final String balance;
  final String title;
  HomeGridModel({
    required this.iconPath,
    required this.balance,
    required this.title,
  });
}
