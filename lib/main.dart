

import 'package:clone_shopping/Routes/app_routes.dart';
import 'package:clone_shopping/utils/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'binding/generalBinding/general_binding.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // Ensure Flutter bindings are ready
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize local storage
  await GetStorage.init();

  // -- ADJUSTMENT 1: Simplified Firebase Initialization --
  // Initialize Firebase first
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Then, inject dependencies. This is cleaner than using .then()
  // Get.put(AuthenticationRepository());

  // if (kDebugMode) {
  //   try {
  //     FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  //     await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  //
  //     // --- ADD THIS LINE FOR STORAGE ---
  //     await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
  //
  //   } catch (e) {
  //     print('Error setting up Firebase Emulators: $e');
  //   }
  // }

  FirebaseAuth.instance.setLanguageCode('en'); // or 'hi', 'ur', etc.
  // -- ADJUSTMENT 2: Use App Check Debug Provider --
  // For development and testing (especially on emulators), use the debug provider.
  // This will prevent the 'App attestation failed' error.
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );



  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialBinding: GeneralBinding(),
      getPages: AppRoutes.pages,

      // The AppStartScreen will be shown initially
      home: const AppStartScreen(),
    );
  }
}

class AppStartScreen extends StatelessWidget {
  const AppStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // -- ADJUSTMENT 3: Placeholder for Screen Redirection --
    // A GetX controller with an onReady() method is a great place
    // to call your screen redirection logic after initialization.
    // For example: AuthenticationRepository.instance.screenRedirect();

      GetStorage().write("isVerified", false);
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}