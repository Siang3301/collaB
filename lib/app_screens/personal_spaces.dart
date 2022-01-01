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
      extendBodyBehindAppBar: true,
        appBar : AppBar(
          centerTitle: true,
          title : const Text("PersonalSpaces", style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold)),
          backgroundColor: Colors.transparent,
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
            decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage('assets/images/personalspaces-ui.webp'),
            fit: BoxFit.cover)),
        child: Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.bottomCenter, colors: [
            Colors.black.withOpacity(0.8),
            Colors.black.withOpacity(0.7)
            ])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    child: const Text('In development..... \nComing soon in 4th Sprint', textAlign: TextAlign.center, softWrap: false,
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          fontSize: 19.0,
                        ))),
              ],)
          ),
        ),
    );
  }
}