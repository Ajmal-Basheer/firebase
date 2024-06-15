import 'package:firebase/Authentication/firebase_options.dart';
import 'package:firebase/CloudMessaging/FirebaseInAppMsg.dart';
import 'package:firebase/InAppMessage.dart';
import 'package:firebase/CloudStore/FirebaseDelete.dart';
import 'package:firebase/CloudStore/FirebaseUpdate.dart';
import 'package:firebase/CloudStore/firebaseAdd.dart';
import 'package:firebase/CloudStore/firebaseView.dart';
import 'package:firebase/Storage/FireStore.dart';
import 'package:firebase/Storage/ViewFireStore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'CloudMessaging/firebasemsg.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessageBackgroundHandler);
  runApp(const MyApp());
}
Future<void> _firebaseMessageBackgroundHandler(RemoteMessage message)async{
  print('Handling a background message :${message.messageId}');
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FireStore(),
      debugShowCheckedModeBanner: false,
    );
  }
}
