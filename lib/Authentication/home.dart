import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {  @override
  State<StatefulWidget> createState() => homeState();
}
class homeState extends State {  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: SafeArea(
        child: Center(
          child: Text('hello friends'),
        ),
      ),
    );
  }
}
