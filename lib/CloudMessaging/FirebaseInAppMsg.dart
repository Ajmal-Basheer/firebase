import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';

class FirebaseInAppMessagingService{
  FirebaseInAppMessagingService._();
  static final FirebaseInAppMessagingService _instance = FirebaseInAppMessagingService._();
  factory FirebaseInAppMessagingService()=>_instance;
  final FirebaseInAppMessaging _firebaseInAppMessaging = FirebaseInAppMessaging.instance;

  Future disableInAppMsg()async {
    await _firebaseInAppMessaging.setMessagesSuppressed(true);
  }
  Future enableInAppMsg()async {
    await _firebaseInAppMessaging.setMessagesSuppressed(false);
  }
}