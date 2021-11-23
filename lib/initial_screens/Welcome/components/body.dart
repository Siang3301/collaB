import 'package:flutter/material.dart';
import 'package:collab/initial_screens/Login/login_screen.dart';
import 'package:collab/initial_screens/Signup/signup_screen.dart';
import 'package:collab/initial_screens/Welcome/components/background.dart';
import 'package:collab/initial_components/rounded_button.dart';
import 'package:collab/constants.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.08),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right:185),
            child: Text(
              "collaB",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35, fontFamily: 'Raleway', color: Colors.white, shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.white,
                  offset: Offset(3.0, 3.0),
                ),
              ],
              ),
            ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left:85),
              child : Text("- Simplify your work -",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, fontFamily: 'Raleway', color: Colors.white)),
            ),

            SizedBox(height: size.height * 0.40),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
