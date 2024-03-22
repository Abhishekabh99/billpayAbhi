import 'package:billpe/views/bill/add_bill_screen.dart';
import 'package:go_router/go_router.dart';

class BillPath {
  static const String addBill = "/add-bill";
}

final List<RouteBase> billRouter = [
  GoRoute(
    path: BillPath.addBill,
    name: BillPath.addBill,
    builder: (context, state) {
      return const AddBillScreen();
    },
  ),
];
