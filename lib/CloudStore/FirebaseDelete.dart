import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class firebaseDelete extends StatefulWidget {  @override
State<StatefulWidget> createState()=> firebaseDeleteState();
}
class firebaseDeleteState extends State {
  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> deleteUser(String documentId) async {
    await users.doc(documentId).delete();
    print('User deleted successfully!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Delete'),
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
                      trailing: IconButton(
                            icon: Icon(Icons.delete,color: Colors.red,size: 20,),
                                              onPressed: (){
                              showDialog(
                                  context: context,
                                  builder: (context)=>AlertDialog(
                                    title: Text('Delete Data'),
                                    content: Text('Are you sure ? '),
                                    actions: [
                                      TextButton(onPressed: (){
                                        Navigator.pop(context);
                                      },
                                          child: Text('cancel',style: TextStyle(color: Colors.green),)),

                                      TextButton(onPressed: (){
                                         deleteUser(document.id);
                                         Navigator.pop(context);
                                      }, child: Text('Delete',style: TextStyle(color: Colors.red),))
                                    ],
                                  ));

                                              },

                      ),

                    );
                  });
            }),
      ),
    );
  }
}
