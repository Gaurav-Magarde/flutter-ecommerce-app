import 'dart:async';

import 'package:clone_shopping/NavigationMenu.dart';
import 'package:clone_shopping/features/authentication/screens/SignUpScreen/Verify_email.dart';
import 'package:clone_shopping/features/authentication/screens/login/loginScreen.dart';
import 'package:clone_shopping/features/personalization/userRepository/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';import 'package:google_sign_in/google_sign_in.dart';
import 'package:get_storage/get_storage.dart';
import '../../../features/authentication/screens/onboarding/onBoarding.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  final _auth = FirebaseAuth.instance;

  User? user = FirebaseAuth.instance.currentUser;

  ///variables
  final deviceStorage = GetStorage();

  ///called on app launch
  @override
  void onReady() {
    // FlutterNativeSplash.remove();

    screenRedirect();
  }

  ///Show Screen According to user authentication
  screenRedirect({UserCredential? currentUser})  async {
    final user = currentUser?.user ?? FirebaseAuth.instance.currentUser;
    this.user = user;
    if(user != null) {

      if(!Get.isRegistered<UserController>()){
        Get.put(UserController());
      }

      await UserController.instance.fetchUserRecord();
      Get.offAll(
            () => (user.emailVerified) ? NavigationMenu() : VerifyEmailScreen(email: user.email?? "",),
          );
    }else {

      deviceStorage.writeIfNull("IsFirstTime", true);
      bool isFirstTime = (deviceStorage.read("IsFirstTime") != true);
      Get.offAll(
            !isFirstTime
                ? () => const LoginScreen()
                : () => onBoardingScreen(),
          );
    }
  }

  /// [GoogleAuthentication] SignInWithGoogle [---------------------------------------------]
  Future<UserCredential> signInWithGoogle() async {
    try{
      await GoogleSignIn().signOut();

      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();


      final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;


      final credentials = GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken,idToken: googleAuth?.idToken);


      return await _auth.signInWithCredential(credentials);



    }// Catch specific Firebase Authentication errors.
    on FirebaseAuthException catch (e) {
      // You can handle specific error codes here if you want.
      // For example: if (e.code == 'weak-password') { ... }
      throw TFirebaseAuthException(e.code).message;
    }
    // Catch other general Firebase-related errors.
    on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    }
    // Catch errors related to incorrect data format.
    on FormatException catch (_) {
      throw const TFormatException().message;
    }
    // Catch errors from the underlying native platform (Android/iOS)
    on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    }
    // Catch any other unexpected errors.
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///Email Authentication
  Future<UserCredential> signInWithEmailAndPassword(String email,String password) async {
    try {

     final userCredential = await _auth.signInWithEmailAndPassword(email: email,password: password);
      return userCredential;
      // await _auth.ins;
    }
    // Catch specific Firebase Authentication errors.
    on FirebaseAuthException catch (e) {
      // You can handle specific error codes here if you want.
      // For example: if (e.code == 'weak-password') { ... }
      throw TFirebaseAuthException(e.code).message;
    }
    // Catch other general Firebase-related errors.
    on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    }
    // Catch errors related to incorrect data format.
    on FormatException catch (_) {
      throw const TFormatException().message;
    }
    // Catch errors from the underlying native platform (Android/iOS)
    on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    }
    // Catch any other unexpected errors.
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///ForgotPassword Reset Password
  Future<void> forgotPasswordEmail(String email) async {
    try {

      await _auth.sendPasswordResetEmail(email: email);

      // await _auth.ins;
    }
    // Catch specific Firebase Authentication errors.
    on FirebaseAuthException catch (e) {
      // You can handle specific error codes here if you want.
      // For example: if (e.code == 'weak-password') { ... }
      throw TFirebaseAuthException(e.code).message;
    }
    // Catch other general Firebase-related errors.
    on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    }
    // Catch errors related to incorrect data format.
    on FormatException catch (_) {
      throw const TFormatException().message;
    }
    // Catch errors from the underlying native platform (Android/iOS)
    on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    }
    // Catch any other unexpected errors.
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Register with
  Future<UserCredential> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      // Attempt to create a new user with Firebase Authentication.

      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    }
    // Catch specific Firebase Authentication errors.
    on FirebaseAuthException catch (e) {
      // You can handle specific error codes here if you want.
      // For example: if (e.code == 'weak-password') { ... }
      throw TFirebaseAuthException(e.code);
    }
    // Catch other general Firebase-related errors.
    on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    }
    // Catch errors related to incorrect data format.
    on FormatException catch (_) {
      throw const TFormatException();
    }
    // Catch errors from the underlying native platform (Android/iOS)
    on PlatformException catch (e) {
      throw TPlatformException(e.code);
    }
    // Catch any other unexpected errors.
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///Email verification
  Future<void> sendEmailVerificationTo() async {
    try {
      // Attempt to create a new user with Firebase Authentication.

       await _auth.currentUser?.sendEmailVerification();
    }
    // Catch specific Firebase Authentication errors.
    on FirebaseAuthException catch (e) {
      // You can handle specific error codes here if you want.
      // For example: if (e.code == 'weak-password') { ... }
      throw TFirebaseAuthException(e.code).message;
    }
    // Catch other general Firebase-related errors.
    on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    }
    // Catch errors related to incorrect data format.
    on FormatException catch (_) {
      throw const TFormatException().message;
    }
    // Catch errors from the underlying native platform (Android/iOS)
    on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    }
    // Catch any other unexpected errors.
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///Logout Function

  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      UserController.instance.clear();
      screenRedirect();
    }
    // Catch specific Firebase Authentication errors.
    on FirebaseAuthException catch (e) {
      // You can handle specific error codes here if you want.
      // For example: if (e.code == 'weak-password') { ... }
      throw TFirebaseAuthException(e.code);
    }
    // Catch other general Firebase-related errors.
    on FirebaseException catch (e) {
      throw TFirebaseException(e.code);
    }
    // Catch errors related to incorrect data format.
    on FormatException catch (_) {
      throw const TFormatException();
    }
    // Catch errors from the underlying native platform (Android/iOS)
    on PlatformException catch (e) {
      throw TPlatformException(e.code);
    }
    // Catch any other unexpected errors.
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
