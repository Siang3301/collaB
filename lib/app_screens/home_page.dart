import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collab/search_appbar_page.dart';
import 'package:flutter/material.dart';
import 'package:collab/app_screens/profile_page.dart';
import 'package:collab/profile_screens/user/user.dart' as u;
import 'package:collab/widgets/provider_widgets.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage>{
  get onPressed => null;
  u.User user = u.User("","","","","");
  final TextEditingController _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of(context)!.auth;
    final db = Provider.of(context)!.db;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar : AppBar(leading: Builder(
              builder: (BuildContext context) {
              return IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => LocalSearchAppBarPage()),);},
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text("collaB", style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold),),
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
          ],),
    body : Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/feed-ui.webp'),
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
               children: <Widget>[
               SizedBox(
                   height: 8.0 * 10,
                 ),
               StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: db
                      .collection('users_data')
                      .doc(auth.getCurrentUID())
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      _userNameController.text = user.username;
                    }
                    var userDocument = snapshot.data;
                    return Container(
                      margin: const EdgeInsets.only(
                          top: 10.0, bottom: 10.0, left: 20.0),
                      // ignore: prefer_adjacent_string_concatenation
                      child: Text('Welcome Back, \n' + '${userDocument?['username']}',
                          style: const TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0)),
                    );
                  }
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
            ],)
        ),
    ),

    );
  }
}






