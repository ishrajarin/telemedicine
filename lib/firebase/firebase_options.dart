
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;


class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
            'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
      apiKey: 'AIzaSyBc4Ow4Ltto6PZCfBzfZMvKdrRM4oZSuFw',
      appId: '1:1045590623502:android:b38196d6d680e244c6435f',
      messagingSenderId: '1045590623502',
      projectId: 'telemedicine-92700',
      storageBucket: 'telemedicine-92700.firebasestorage.app',
      databaseURL:
      'https://telemedicine-92700-default-rtdb.firebaseio.com/');

  static const FirebaseOptions ios = FirebaseOptions(
      apiKey: 'AIzaSyBc4Ow4Ltto6PZCfBzfZMvKdrRM4oZSuFw',
      appId: '1:1045590623502:android:b38196d6d680e244c6435f',
      messagingSenderId: '1045590623502',
      projectId: 'telemedicine-92700',
      storageBucket: 'telemedicine-92700.firebasestorage.app',
      iosBundleId: 'com.israt.tele_medicine',
      databaseURL:
      'https://telemedicine-92700-default-rtdb.firebaseio.com/');
}