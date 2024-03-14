import 'package:billpe/features/notification/notification_screen.dart';
import 'package:go_router/go_router.dart';

class NotificationPath {
  static const String notification = "/notification";
}

final List<RouteBase> notificationRouter = [
  GoRoute(
    path: NotificationPath.notification,
    name: NotificationPath.notification,
    builder: (context, state) {
      return const NotificationScreen();
    },
  ),
];
