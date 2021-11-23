import 'package:flutter/material.dart';
import 'profilePage.dart';

class HomePage extends StatefulWidget{
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage>{
  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar : AppBar(leading: const Icon(Icons.search),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: const Text("collaB"),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.account_circle_rounded),
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
      padding: const EdgeInsets.only(right: 100),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color.fromRGBO(1, 89, 99, 1.0), Colors.grey],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),

      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0),
                  child: const Text("Welcome Back, \nAzaiman!",
                      style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0)),
                ),

                Container(
                    margin: const EdgeInsets.only(top: 170.0, bottom: 100.0, left:50.0),
                    child: const Text('No Feeds. \nCurrently you have no notifications', textAlign: TextAlign.center, softWrap: false,
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          fontSize: 19.0,
                        ))),
              ],
          ),
       ),
    ),
    );
  }
}






