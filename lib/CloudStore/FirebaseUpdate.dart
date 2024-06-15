import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class firebaseUpdate extends StatefulWidget {  @override
State<StatefulWidget> createState()=> firebaseUpdateState();
}
class firebaseUpdateState extends State {
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  final TextEditingController _username = TextEditingController();

  Future<void>userUpdate(String documentid,String newUsername)async{
    await users.doc(documentid).update(
        {'username': newUsername,}
    );
    print('User Update Successfully');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Update'),
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
                      trailing:
                      IconButton(
                        icon: Icon(Icons.edit,color: Colors.black,size: 20,),
                        onPressed: (){
                         showDialog(
                             context: context,
                             builder: (context)=> AlertDialog(
                               title: Text('Update User'),
                               content: Column(
                                 mainAxisSize: MainAxisSize.min,
                                 children: [
                                   TextField(
                                     controller: _username,
                                     decoration: InputDecoration(
                                       hintText: 'New User Name'
                                     ),
                                   ),
                                   TextField(
                                     controller: TextEditingController(text: document['password']),
                                     obscureText: true,
                                     decoration: InputDecoration(
                                       enabled: false,
                                     ),
                                   )
                                 ],
                               ),
                               actions: [
                                 TextButton(onPressed: (){
                                   Navigator.pop(context);
                                 },
                                     child: Text('cancel',style: TextStyle(color: Colors.red),)),

                                 TextButton(onPressed: (){
                                   userUpdate(document.id,_username.text);
                                   Navigator.pop(context);
                                 }, child: Text('Update',style: TextStyle(color: Colors.green),))
                               ],

                             ));
                        },),

                    );
                  });
            }),
      ),
    );
  }
}
