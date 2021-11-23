import 'package:flutter/material.dart';
import '../main.dart';

class profilePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Profile"),
      ),
    );

  }
}


class Body extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Column(
      children:[
        SizedBox(
        height: 200,
        width: 200,
        child: Stack(
          children:[CircleAvatar(
              backgroundImage: AssetImage("assets/images/persona.jpg"),
              ),
          ],
        ),
      )
      ]
    );
  }
}