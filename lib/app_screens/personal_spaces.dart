import 'package:collab/app_screens/profile_page.dart';
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
          centerTitle: true,
          title : const Text("PersonalSpaces", style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold)),
          backgroundColor: Colors.indigo,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.account_circle_rounded),
              highlightColor: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => profilePage()),
                );
              },
            ),
          ],
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
              child : Text("In development...", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            )
        ),

    );
  }
}