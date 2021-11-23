import 'package:flutter/material.dart';
import 'HomePage.dart';

class PersonalSpaces extends StatefulWidget{
  _PersonalSpacesState createState() => _PersonalSpacesState();
}

class _PersonalSpacesState extends State<PersonalSpaces>{
  Widget build(BuildContext context){
    return new Scaffold(
        appBar : new AppBar(
          title : new Text("PersonalSpaces"),
          backgroundColor: Colors.indigo,
          automaticallyImplyLeading: true,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios),
            onPressed:() => HomePage(),
          ),
        ),
        body : new Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromRGBO(1, 89, 99, 1.0), Colors.grey],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
            child : Center(
              child : Text("PersonalSpaces page."),
            )
        )
    );
  }
}