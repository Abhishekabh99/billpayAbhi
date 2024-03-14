import 'package:billpe/features/profile/store_profile_screen.dart';
import 'package:go_router/go_router.dart';

class StoreProfilePath {
  static const String storeProfile = "/store-profile";
}

final List<RouteBase> storeProfileRouter = [
  GoRoute(
    path: StoreProfilePath.storeProfile,
    name: StoreProfilePath.storeProfile,
    builder: (context, state) {
      return const StoreProfileScreen();
    },
  ),
];
