import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class firebaseAdd extends StatefulWidget {  @override
  State<StatefulWidget> createState()=> firebaseAddState();
}
class firebaseAddState extends State {

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Future<void> _addData()async{
  try {
    //Get Firestore instance
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    //Collection reference
    CollectionReference users = firebaseFirestore.collection('users');
    //add document with data
    await users.add(
    {
    'username' : _username.text,
      'password' : _password.text,
    }
    );
    print('data add Successfully');
  }catch(e){
  print('error adding data : $e');
  }
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: SafeArea(
       child: Center(
         child: Container(
           padding: EdgeInsets.all(20),
           child: Column(
             children: [
               Text('ADD DATA'),
               SizedBox(height: 15,),
               TextField(
                 controller: _username,
                 decoration: InputDecoration(
                   hintText: 'User Name',
                 ),
               ),
               SizedBox(height: 15,),
               TextField(
                 controller: _password,
                 decoration: InputDecoration(
                   hintText: 'password',
                 ),
               ),
               SizedBox(height: 15,),
               ElevatedButton(onPressed: ()async{
                 await _addData();
               }, child: Text('Add Data'))
             ],
           ),
         ),
       ),
     ),
   );
  }
}
