// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDeP8cdYUw7ZVGnf-co43MlgGlwv9Hlm0w',
    appId: '1:976187858833:web:057bbdfd5c767820c3c430',
    messagingSenderId: '976187858833',
    projectId: 'too-good-to-go-admin',
    authDomain: 'too-good-to-go-admin.firebaseapp.com',
    storageBucket: 'too-good-to-go-admin.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA-4eTD0w7BbTxStb0wNE-Ifj2MHOxM03k',
    appId: '1:976187858833:android:76870fe3dfbaf78fc3c430',
    messagingSenderId: '976187858833',
    projectId: 'too-good-to-go-admin',
    storageBucket: 'too-good-to-go-admin.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCK5gNdtJ0X_rtVizUpN9H4W9tl-ew_2To',
    appId: '1:976187858833:ios:758af25355c76adac3c430',
    messagingSenderId: '976187858833',
    projectId: 'too-good-to-go-admin',
    storageBucket: 'too-good-to-go-admin.appspot.com',
    iosBundleId: 'com.example.tooGoodToGoApp',
  );
}
