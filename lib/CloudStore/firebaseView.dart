import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class firebaseView extends StatefulWidget {  @override
  State<StatefulWidget> createState()=> firebaseViewState();
}
class firebaseViewState extends State {
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Data'),
        backgroundColor: Colors.greenAccent,
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: users.snapshots(),
            builder: (context, snapshot){
              if(!snapshot.hasData){
              return  CircularProgressIndicator();
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,index){
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    return ListTile(
                      title: Text(document['username']),
                      subtitle: Text(document['password']),
                    );
                  });
            }),
      ),
    );
  }
}
