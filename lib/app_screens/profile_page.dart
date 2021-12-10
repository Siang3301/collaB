import 'package:collab/google_sign_up.dart';
import 'package:collab/initial_screens/Welcome/welcome_screen.dart';
import 'package:collab/profile_screens/pages/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class profilePage extends StatefulWidget{
  const profilePage({Key? key}) : super(key: key);

  @override
  _profilePage createState() => _profilePage();
}

// ignore: camel_case_types
class _profilePage extends State<profilePage>{

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text("Profile"),
        actions: [
          TextButton(
            child: const Text('Logout', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            onPressed: (){
              GoogleAuthentication.logout();
              auth.signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => WelcomeScreen()),
                  ModalRoute.withName('/')
              );
            },
          )
        ]


      ),
      body: ProfileView(),
    );

  }
}


class Body extends StatelessWidget{
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      children:[
        SizedBox(
        height: 200,
        width: 200,
        child: Stack(
          children:const [CircleAvatar(
              backgroundImage: AssetImage("assets/images/persona.jpg"),
              ),
          ],
        ),
      )
      ]
    );
  }
}