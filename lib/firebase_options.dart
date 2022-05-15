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
    apiKey: 'AIzaSyA07gOQLRRz8tDjCdvheCg0Erxlv2bnM_I',
    appId: '1:1050608125927:web:44f8eec205fc2f91691f42',
    messagingSenderId: '1050608125927',
    projectId: 'chill-hub',
    authDomain: 'chill-hub.firebaseapp.com',
    storageBucket: 'chill-hub.appspot.com',
    measurementId: 'G-W3253BNNPF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAZi7jCVOE_naMs7RyP8kkwnpg5dNqQJYo',
    appId: '1:1050608125927:android:4fb0fe9c6af81c5b691f42',
    messagingSenderId: '1050608125927',
    projectId: 'chill-hub',
    storageBucket: 'chill-hub.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBnYk-Tcac6plePH5DVX7Y4QgCpctJ_9CU',
    appId: '1:1050608125927:ios:d235c41aa2e4f25c691f42',
    messagingSenderId: '1050608125927',
    projectId: 'chill-hub',
    storageBucket: 'chill-hub.appspot.com',
    iosClientId: '1050608125927-veba3al25q1des89f347ad3kc91psfbd.apps.googleusercontent.com',
    iosBundleId: 'com.example.chillHub',
  );
}
