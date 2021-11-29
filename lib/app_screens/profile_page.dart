import 'package:collab/google_sign_in.dart';
import 'package:collab/initial_screens/Welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class profilePage extends StatelessWidget{
  const profilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text("Profile"),
        actions: [
          TextButton(
            child: const Text('Logout'),
            onPressed: (){
              final provider = Provider.of<GoogleSignInProvider>(context,listen:false);
              provider.logout();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
              );
            },
          )
        ]
      ),
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