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
        return macos;
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
    apiKey: 'AIzaSyBGgiFOYzLz-oXzjD1rlOfQIpl5y5TPnk8',
    appId: '1:465469310744:web:df10cf4ab5e186ce7ac06d',
    messagingSenderId: '465469310744',
    projectId: 'learnchatflutter',
    authDomain: 'learnchatflutter.firebaseapp.com',
    storageBucket: 'learnchatflutter.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCZB-n9hixB_jTZRRHaQ2yESoG9MY2u1YY',
    appId: '1:465469310744:android:2a7e3e00f21435127ac06d',
    messagingSenderId: '465469310744',
    projectId: 'learnchatflutter',
    storageBucket: 'learnchatflutter.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDvZHCz-2RwMYs7B3h_xJk-5jSliKCsuFY',
    appId: '1:465469310744:ios:ec3eaf43c62dde757ac06d',
    messagingSenderId: '465469310744',
    projectId: 'learnchatflutter',
    storageBucket: 'learnchatflutter.appspot.com',
    iosBundleId: 'com.example.flutterChat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDvZHCz-2RwMYs7B3h_xJk-5jSliKCsuFY',
    appId: '1:465469310744:ios:189b59534942cfaa7ac06d',
    messagingSenderId: '465469310744',
    projectId: 'learnchatflutter',
    storageBucket: 'learnchatflutter.appspot.com',
    iosBundleId: 'com.example.flutterChat.RunnerTests',
  );
}