import 'package:firebase/Authentication/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => signupState();
}
class signupState extends State {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  late bool _success;
  late String _userEmail;


  Future<void> _register()async{
    try
        {
          UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
              email: _email.text,
              password: _password.text);
          setState(() {
            _success = true;
            _userEmail = userCredential.user!.email!;
            _email.clear();
            _password.clear();
          });
        }on FirebaseAuthException catch(e){
      setState(() {
        _success = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.greenAccent,
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
              Text('Sign Up',style: TextStyle(fontSize: 20),),
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
                  onPressed:()async{
                    await _register();
                  } ,
                  child: Text('Sign Up',style: TextStyle(color: Colors.white),),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
              ),
              TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>signin()));
                  },
                  child: Text('Sign In',style: TextStyle(color: Colors.red),))
            ],
          ),
        ),
      ),
    )
  );
  }
}
