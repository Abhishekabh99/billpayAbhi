import 'package:billpe/features/stock/stock_screen.dart';
import 'package:go_router/go_router.dart';

class StockPath {
  static const String stock = "/stock";
}

final List<RouteBase> stockRouter = [
  GoRoute(
    path: StockPath.stock,
    name: StockPath.stock,
    builder: (context, state) {
      return const StockScreen();
    },
  ),
];
