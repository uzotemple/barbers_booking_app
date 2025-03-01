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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyBmdlDAl1yxdi8Gm7jRdRZb3D8garpNK8U',
    appId: '1:916295604888:web:9c8d8c37f62131aa290eed',
    messagingSenderId: '916295604888',
    projectId: 'barbersapp-a1546',
    authDomain: 'barbersapp-a1546.firebaseapp.com',
    storageBucket: 'barbersapp-a1546.appspot.com',
    measurementId: 'G-8SKRD6YMBG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDWATfBBHsww5uQkb-1qECr8iuB9AIESaI',
    appId: '1:916295604888:android:f63e7451454bb4b4290eed',
    messagingSenderId: '916295604888',
    projectId: 'barbersapp-a1546',
    storageBucket: 'barbersapp-a1546.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB4bh-27RJ1sZbYG0pZVP9hF2h5yyvDjH8',
    appId: '1:916295604888:ios:eaefc9013673af94290eed',
    messagingSenderId: '916295604888',
    projectId: 'barbersapp-a1546',
    storageBucket: 'barbersapp-a1546.appspot.com',
    iosBundleId: 'com.example.barbersapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB4bh-27RJ1sZbYG0pZVP9hF2h5yyvDjH8',
    appId: '1:916295604888:ios:eaefc9013673af94290eed',
    messagingSenderId: '916295604888',
    projectId: 'barbersapp-a1546',
    storageBucket: 'barbersapp-a1546.appspot.com',
    iosBundleId: 'com.example.barbersapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBmdlDAl1yxdi8Gm7jRdRZb3D8garpNK8U',
    appId: '1:916295604888:web:bc1c865dcaaf9af4290eed',
    messagingSenderId: '916295604888',
    projectId: 'barbersapp-a1546',
    authDomain: 'barbersapp-a1546.firebaseapp.com',
    storageBucket: 'barbersapp-a1546.appspot.com',
    measurementId: 'G-Y00E6GBJNB',
  );
}
