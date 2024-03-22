import 'package:billpe/views/auth/auth_screen.dart';
import 'package:billpe/views/auth/billpe_store_details.dart';
import 'package:billpe/views/auth/choose_lang_screen.dart';
import 'package:billpe/views/auth/otp_screen.dart';
import 'package:billpe/views/auth/splash_screen.dart';
import 'package:billpe/views/profile/store_profile_pic.dart';
import 'package:go_router/go_router.dart';

class AuthPath {
  static const String login = "/login";
  static const String verifyOTP = "/verifyOTP";
  static const String billPeStoreDetails = "/billPeStoreDetails";
  static const String splash = "/splash";
  static const String storeProfilePic = "/store-profile-pic";
  static const String chooseLang = "/chooseLang";
}

final List<RouteBase> authRouter = [
  GoRoute(
    path: AuthPath.login,
    name: AuthPath.login,
    builder: (context, state) {
      return const AuthScreen();
    },
  ),
  GoRoute(
    path: AuthPath.verifyOTP,
    name: AuthPath.verifyOTP,
    builder: (context, state) {
      final String phoneNumber = (state.extra as Map)['phoneNumber'] ?? "";
      return OtpScreen(
        phoneNumber: phoneNumber,
      );
    },
  ),
  GoRoute(
    path: AuthPath.billPeStoreDetails,
    name: AuthPath.billPeStoreDetails,
    builder: (context, state) {
      // final user = UserLocalStorage.getUserData();
      String phoneNumber = "";
      // if (user?.name == null) {
      //   phoneNumber = (state.extra as Map)['phoneNumber'] ?? "";
      // } else {
      //   phoneNumber = user?.whatsappNo ?? "";
      // }
      return BillPeStoreDetails(
        phoneNumber: phoneNumber,
      );
    },
  ),
  GoRoute(
    path: AuthPath.splash,
    name: AuthPath.splash,
    builder: (context, state) {
      return const SplashScreen();
    },
  ),
  GoRoute(
    path: AuthPath.storeProfilePic,
    name: AuthPath.storeProfilePic,
    builder: (context, state) {
      final String phoneNumber = (state.extra as Map)['phoneNumber'] ?? "";
      final String storeID = (state.extra as Map)['storeID'] ?? "";
      return StoreProfilePic(
        phoneNumber: phoneNumber,
        storeID: storeID,
      );
    },
  ),
  GoRoute(
    path: AuthPath.chooseLang,
    name: AuthPath.chooseLang,
    builder: (context, state) {
      String phoneNumber = "";
      phoneNumber = (state.extra as Map)['phoneNumber'] ?? "";

      return ChooseLanguageScreen(
        phoneNumber: phoneNumber,
      );
    },
  ),
];
