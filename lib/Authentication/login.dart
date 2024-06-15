import 'package:firebase/Authentication/home.dart';
import 'package:firebase/Authentication/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class signin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => signinState();
}
class signinState extends State {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  String _Useremail = '';
  int _success = 1;

  Future<void> _signin()async{
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _email.text,
          password: _password.text);
      if(userCredential!=null){
        setState(() {
          _success = 2;
          _Useremail = userCredential.user!.email!;
          Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
        });
      }
    }on FirebaseAuthException catch(e){
    setState(() {
      _success = 3;
    });
    }
  }
  @override
Widget build(BuildContext context) {
  return Scaffold(
      backgroundColor:Colors.greenAccent,
      body: SafeArea(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width/1.5,
            height: MediaQuery.of(context).size.height/2.7,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Sign In',style: TextStyle(fontSize: 20),),
                TextField(
                  controller: _email,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: _password,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: ()async{
                    await _signin();
                  },
                  child: Text('Sign In',style: TextStyle(color: Colors.white),),
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
                ),
                TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>signup()));
                    },
                    child: Text('Sign Up',style: TextStyle(color: Colors.red),))
              ],
            ),
          ),
        ),
      )
  );
}
}
