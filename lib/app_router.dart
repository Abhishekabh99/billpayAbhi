import 'package:billpe/service/local_storage.dart';
import 'package:billpe/views/auth/auth_router.dart';
import 'package:billpe/views/bill/bill_router.dart';
import 'package:billpe/views/home/main_router.dart';
import 'package:billpe/views/notification/notification_router.dart';
import 'package:billpe/views/profile/store_profile_router.dart';
import 'package:billpe/views/stock/stock_router.dart';
import 'package:go_router/go_router.dart';

final token = LocalStorage.getToken();
final appRouter = GoRouter(
  initialLocation: token != null
      // ? StoreLocalStorage.getStoreData()?.shopName != null
      ? MainPath.main
      // : AuthPath.billPeStoreDetails
      : AuthPath.splash,
  routes: [
    ...mainRouter,
    ...authRouter,
    ...billRouter,
    ...stockRouter,
    ...notificationRouter,
    ...storeProfileRouter,
  ],
);
