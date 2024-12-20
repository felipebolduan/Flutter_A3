// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyABUXGqHd00SsO4ILw5TC9kgyTSAu8-q1c',
    appId: '1:331611595250:web:75332f4f25e613c3f78b6b',
    messagingSenderId: '331611595250',
    projectId: 'flutter-projeto-a3',
    authDomain: 'flutter-projeto-a3.firebaseapp.com',
    storageBucket: 'flutter-projeto-a3.firebasestorage.app',
    measurementId: 'G-8YTW6MC2GB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDqmDWFzVt_SwXhm5vp6gRzoVxrY-nmCFo',
    appId: '1:331611595250:android:3e9d59faa2cdea22f78b6b',
    messagingSenderId: '331611595250',
    projectId: 'flutter-projeto-a3',
    storageBucket: 'flutter-projeto-a3.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDv9rfpWMehJj0E6fc-hXD2jT0sez7YGu8',
    appId: '1:331611595250:ios:2f8dcc36476d9f20f78b6b',
    messagingSenderId: '331611595250',
    projectId: 'flutter-projeto-a3',
    storageBucket: 'flutter-projeto-a3.firebasestorage.app',
    iosBundleId: 'com.example.projetoA3',
  );

}