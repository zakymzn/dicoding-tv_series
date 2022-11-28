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
    apiKey: 'AIzaSyAeg14neeQn0dSUp-zL46gZFlp7rz-qiLU',
    appId: '1:645985451139:web:01467c6927a0ca20fdafb6',
    messagingSenderId: '645985451139',
    projectId: 'ditonton-e3b0a',
    authDomain: 'ditonton-e3b0a.firebaseapp.com',
    storageBucket: 'ditonton-e3b0a.appspot.com',
    measurementId: 'G-9BQE64W04Z',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCgbUahtisX6yq88HS0UgMtyQzD8GVYU8A',
    appId: '1:645985451139:android:b48cf0e0b9283c61fdafb6',
    messagingSenderId: '645985451139',
    projectId: 'ditonton-e3b0a',
    storageBucket: 'ditonton-e3b0a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBzy3L_v1rbIAEolOAuHvmOrUJZgPtgW_U',
    appId: '1:645985451139:ios:c5d65df80f361051fdafb6',
    messagingSenderId: '645985451139',
    projectId: 'ditonton-e3b0a',
    storageBucket: 'ditonton-e3b0a.appspot.com',
    iosClientId: '645985451139-prlq6q168pg0ad93daqecshk1k3e50ml.apps.googleusercontent.com',
    iosBundleId: 'com.dicoding.ditonton',
  );
}
