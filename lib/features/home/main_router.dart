import 'package:billpe/features/home/main_screen.dart';
import 'package:go_router/go_router.dart';

class MainPath {
  static const String main = "/main";
}

final List<RouteBase> mainRouter = [
  GoRoute(
    path: MainPath.main,
    name: MainPath.main,
    builder: (context, state) {
      return const MainScreen();
    },
  ),
];
