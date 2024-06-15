
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FirestoreView extends StatefulWidget {  @override
  State<StatefulWidget> createState() => FirestoreViewState();
}
class FirestoreViewState extends State {

  Future<void>ViewStorage()async{
    final path = 'Files/';
    final reference = FirebaseStorage.instance.ref().child(path);
    await reference.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    );
  }
}
