import 'package:billpe/global/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  List<ReportModel> reports = [
    ReportModel(iconPath: "assets/icons/sales_box.png", title: "Sales"),
    ReportModel(iconPath: "assets/icons/contract.png", title: "Tax"),
    ReportModel(iconPath: "assets/icons/person_play.png", title: "Customers"),
    ReportModel(iconPath: "assets/icons/checklist.png", title: "Purchase"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          "Report",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: reports.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 30,
                crossAxisSpacing: 30,
              ),
              itemBuilder: (context, index) {
                final report = reports[index];
                return InkWell(
                  onTap: () {
                    HapticFeedback.selectionClick();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Card(
                      surfaceTintColor: Colors.white,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            report.iconPath,
                            width: 45,
                            height: 45,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            report.title,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class ReportModel {
  final String iconPath;
  final String title;
  ReportModel({required this.iconPath, required this.title});
}
