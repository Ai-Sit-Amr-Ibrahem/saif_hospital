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
    apiKey: 'AIzaSyCLGcft7TXFM7FkvI1QYcvfl1Frv8LWccQ',
    appId: '1:527366159289:web:cebb50ef00ac6ad2179468',
    messagingSenderId: '527366159289',
    projectId: 'saifhospital-4672d',
    authDomain: 'saifhospital-4672d.firebaseapp.com',
    storageBucket: 'saifhospital-4672d.appspot.com',
    measurementId: 'G-FK4PPW6462',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBmck7wKe6x1MSotvN-dVti6xst3aq77jU',
    appId: '1:527366159289:android:874ebfc457c5de66179468',
    messagingSenderId: '527366159289',
    projectId: 'saifhospital-4672d',
    storageBucket: 'saifhospital-4672d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDObPlIHpbJDllIqW041QIGEJ_WbC-Ig2Q',
    appId: '1:527366159289:ios:119258e3928aab6f179468',
    messagingSenderId: '527366159289',
    projectId: 'saifhospital-4672d',
    storageBucket: 'saifhospital-4672d.appspot.com',
    iosBundleId: 'com.his.saifHospital.saifHospital',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDObPlIHpbJDllIqW041QIGEJ_WbC-Ig2Q',
    appId: '1:527366159289:ios:80c84f349f1051bb179468',
    messagingSenderId: '527366159289',
    projectId: 'saifhospital-4672d',
    storageBucket: 'saifhospital-4672d.appspot.com',
    iosBundleId: 'com.his.saifHospital.saifHospital.RunnerTests',
  );
}
