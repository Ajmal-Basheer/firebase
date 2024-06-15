import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class FirebaseApi {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;


  Future<void> initNotification()async{
    await firebaseMessaging.requestPermission();
    final fCMToken = await firebaseMessaging.getToken();
    print('Token : $fCMToken');
  }

  Future<void> sendFCM(List<String>tokens,String title,String body)async{
  final String serverKey = '';
  final String fcmurl = 'https://fcm.googleapis.com/fcm/send';

  final Map<String ,dynamic> message = {
    'notification ' : {'title': title,'body': body},
    'registration_ids' :tokens,
    };

  try{
    final response = await http.post (
    Uri.parse(fcmurl),
      body:jsonEncode(message),
      headers : {
      'Content-Type' : 'application/json',
        'Authorization' : 'key = $serverKey'
    },
    );
    if(response.statusCode == 200){
      print('Message Send Successfully');
    }else{
      print('Message Sending Failed.Error : ${response.body}');
    }
  }catch(e){
    print('Error Sending FCM Message :$e');
  }
  }
}