import 'package:flutter/material.dart';

class PersonalSpaces extends StatefulWidget{
  const PersonalSpaces({Key? key}) : super(key: key);

  @override
  _PersonalSpacesState createState() => _PersonalSpacesState();
}

class _PersonalSpacesState extends State<PersonalSpaces>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar : AppBar(
          title : const Text("PersonalSpaces"),
          backgroundColor: Colors.indigo,
          automaticallyImplyLeading: true,
        ),
        body : Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromRGBO(1, 89, 99, 1.0), Colors.grey],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
            child : const Center(
              child : Text("PersonalSpaces page."),
            )
        ),

    );
  }
}