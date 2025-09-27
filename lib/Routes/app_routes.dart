import 'package:clone_shopping/features/%20WishList/wishListScreen.dart';
import 'package:clone_shopping/features/authentication/screens/onboarding/onBoarding.dart';
import 'package:clone_shopping/features/authentication/screens/passwordConfiguration/forgotPassword.dart';
import 'package:clone_shopping/features/shop/Product_Reviews/ProductReviews.dart';
import 'package:clone_shopping/utils/constants/enums.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../features/authentication/screens/SignUpScreen/SignUpScreen.dart';
import '../features/authentication/screens/SignUpScreen/Verify_email.dart';
import '../features/authentication/screens/login/loginScreen.dart';
import '../features/personalization/Screens/Address/address_screen.dart';
import '../features/personalization/Screens/Profile/ProfileScreen.dart';
import '../features/personalization/Screens/setting/SettingScreen.dart';
import '../features/shop/Cart/cart_screen.dart';
import '../features/shop/Strore/StoreScreen.dart';
import '../features/shop/checkout/checkout_screen.dart';
import '../features/shop/home/HomeScreen.dart';
import 'TRoutes.dart';

class AppRoutes{
  static final pages = [
    GetPage(name: TRoutes.home, page: () => const HomeScreen()),
    GetPage(name: TRoutes.store, page: () => const StoreScreen()),
    GetPage(name: TRoutes.favourites, page: () => const WishListScreen()),
    GetPage(name: TRoutes.settings, page: () => const SettingScreen()),
    GetPage(name: TRoutes.productReviews, page: () => const ProductReviewScreen()),
    // GetPage(name: TRoutes.order, page: () => const or()),
    GetPage(name: TRoutes.checkout, page: () => const CheckOutScreen()),
    GetPage(name: TRoutes.cart, page: () => const CartScreen()),
    GetPage(name: TRoutes.userProfile, page: () => const ProfileScreen()),
    GetPage(name: TRoutes.userAddress, page: () => const AddressScreen()),
    GetPage(name: TRoutes.signup, page: () => const SignUpScreen()),
    GetPage(name: TRoutes.verifyEmail, page: () => const VerifyEmailScreen(email: '',)),
    GetPage(name: TRoutes.signIn, page: () => const LoginScreen()),
    GetPage(name: TRoutes.forgetPassword, page: () => const ForgotPassword()),
    GetPage(name: TRoutes.onBoarding, page: () => const onBoardingScreen()),

// Add more GetPage entries as needed

  ];
}