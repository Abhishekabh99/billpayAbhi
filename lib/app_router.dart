import 'package:billpe/features/auth/auth_router.dart';
import 'package:billpe/features/auth/store_local_db.dart';
import 'package:billpe/features/auth/user_local_db.dart';
import 'package:billpe/features/bill/bill_router.dart';
import 'package:billpe/features/home/main_router.dart';
import 'package:billpe/features/notification/notification_router.dart';
import 'package:billpe/features/profile/store_profile_router.dart';
import 'package:billpe/features/stock/stock_router.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: UserLocalStorage.getUserData()?.name != null
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
