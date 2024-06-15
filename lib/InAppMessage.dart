import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class inAppMsg extends StatefulWidget {  @override
  State<StatefulWidget> createState() => inAppMsgState();
}
class inAppMsgState extends State {

  late String Currentversion;

  @override
  void initState(){
    super.initState();
    _initpackageInfo();
  }

  Future<void>_initpackageInfo()async {
    try{
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      Currentversion = packageInfo.version;

      if(Currentversion != '2.0.0'){
        showUpdatepopUp();
      }
    }catch(e){
     print('Error Getting Package info : $e');
    }
  }

void showUpdatepopUp(){
       setState(() {
         showDialog(
             context: context,
             builder: (context)=>AlertDialog(
               title: Text('update '),
               content: Text('update your app ! '),
               actions: [
                 TextButton(onPressed: (){
                   Navigator.pop(context);
                 },
                     child: Text('cancel',style: TextStyle(color: Colors.green),)),
                 TextButton(onPressed: (){
                 launch('https://www.youtube.com/');
                 }, child: Text('update',style: TextStyle(color: Colors.red),))
               ],
             ));
       });
      }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Text('In App Message'),
          )),
    );
  }
}
