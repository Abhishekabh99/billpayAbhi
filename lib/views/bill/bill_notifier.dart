import 'package:flutter_riverpod/flutter_riverpod.dart';

final addBillNotifierProvider =
    AsyncNotifierProvider<AddBillNotifier, List<BillModel>>(() {
  return AddBillNotifier();
});

class AddBillNotifier extends AsyncNotifier<List<BillModel>> {
  List<BillModel> billModelList = [
    BillModel(billNumber: 1, billName: "Bill", isActive: true)
  ];

  addBill(int index) {
    for (final element in billModelList) {
      element.isActive = false;
    }
    billModelList.add(BillModel(
      billNumber: billModelList.last.billNumber + 1,
      billName: "Bill",
      isActive: true,
    ));
    state = AsyncData(billModelList);
  }

  markBillActive(index) {
    for (final element in billModelList) {
      if (billModelList.indexOf(element) == index) {
        element.isActive = true;
      } else {
        element.isActive = false;
      }
    }
    state = AsyncData(billModelList);
  }

  removeBill(int index) {
    billModelList.removeAt(index);
    state = AsyncData(billModelList);
  }

  @override
  List<BillModel> build() {
    return billModelList;
  }
}

class BillModel {
  int billNumber;
  String billName;
  bool isActive;
  List<BillProductModel>? billProduct;
  BillModel({
    required this.billNumber,
    required this.billName,
    required this.isActive,
    this.billProduct,
  });
}

class BillProductModel {
  String? icon;
  String productName;
  String productQuantityType;
  String? productQuantityValue;
  int productQuantity;
  num? productDiscount;
  num productAmount;

  BillProductModel({
    this.icon,
    required this.productName,
    required this.productQuantity,
    required this.productQuantityType,
    this.productQuantityValue,
    this.productDiscount,
    required this.productAmount,
  });
}
