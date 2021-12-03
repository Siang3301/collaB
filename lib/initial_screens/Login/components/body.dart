// ignore_for_file: implementation_imports
import 'package:collab/authenticate_page.dart';
import 'package:collab/google_sign_up.dart';
import 'package:collab/email_auth.dart';
import 'package:collab/initial_screens/Signup/components/or_divider.dart';
import 'package:collab/main.dart';
import 'package:flutter/material.dart';
import 'package:collab/initial_screens/Login/components/background.dart';
import 'package:collab/initial_screens/Signup/signup_screen.dart';
import 'package:collab/initial_components/already_have_an_account_acheck.dart';
import 'package:collab/initial_components/rounded_button.dart';
import 'package:collab/initial_components/rounded_input_field.dart';
import 'package:collab/initial_components/rounded_password_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/src/provider.dart';

class LoginBody extends StatefulWidget{
  const LoginBody({Key? key}) : super(key: key);

  @override
  _LoginBody createState() => _LoginBody();
}

class _LoginBody extends State<LoginBody> {
  String _email = "", _password = "";
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
    child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 120, right: 250),
              child:Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, fontFamily: 'Raleway'),
            ),
            ),
            SizedBox(height: size.height * 0.03),

            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
            ),
            SizedBox(height: size.height * 0.03),
            RoundedPasswordField(
              onChanged: (value) {
                setState(() {
                  _password = value.trim();
                });
              },
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "LOGIN",
              press: () async{
                setState(() {
                });

                String? user = await context.read<EmailAuthentication>()
                    .signIn(
                  email: _email.trim(),
                  password: _password.trim(),
                );

                setState(() {
                });
                if (user != null) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => bottomNavigationBar(),
                    ),
                  );
                }
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton.icon(
                  style:ElevatedButton.styleFrom(
                    primary:Colors.white,
                    onPrimary: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, fontFamily: 'Raleway'),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    side: BorderSide(width: 0.7, color: Colors.deepOrangeAccent),
                    shadowColor: Colors.deepOrangeAccent,
                  ),
                  icon: FaIcon(FontAwesomeIcons.google, color: Colors.red,),
                  label:Text('Sign In with Google'),
                  onPressed: () async {
                    setState(() {
                    });

                    User? user =
                    await GoogleAuthentication.signInWithGoogle(context: context);

                    setState(() {
                    });

                    if (user != null) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => bottomNavigationBar(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),

            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
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

Future navigateToHomePage(context) async {
  final googleSignIn = GoogleSignIn();
  final googleUser = await googleSignIn.signIn();
  if (googleUser != null) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => bottomNavigationBar()));
  }
  else {
    return;
  }
}

void signInWithGoogle(BuildContext context) async {
  final googleSignIn = GoogleSignIn();
  final googleUser = await googleSignIn.signIn();
  if (googleUser != null) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AuthenticatePage()));
  }
  else {
    return;
  }
}




