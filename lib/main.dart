import 'package:collab/authenticate_page.dart';
import 'package:collab/google_sign_up.dart';
import 'package:collab/initial_screens/Login/login_screen.dart';
import 'package:collab/initial_screens/Signup/signup_screen.dart';
import 'package:collab/initial_screens/Welcome/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './app_screens/home_page.dart';
import './app_screens/projects.dart';
import './app_screens/personal_spaces.dart';
import 'package:firebase_core/firebase_core.dart';
import 'email_auth.dart';
import 'package:provider/provider.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(Collab());
}

class Collab extends StatelessWidget {
  const Collab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // 2
        Provider<EmailAuthentication>(
          create: (_) => EmailAuthentication(FirebaseAuth.instance),
        ),

        Provider<GoogleAuthentication>(
          create: (context) => GoogleAuthentication(),
        ),
        // 3
        StreamProvider(
          create: (context) =>
          context
              .read<EmailAuthentication>()
              .authStateChanges,
          initialData: null,
        ),
      ],
      // TODO: implement build
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => AuthenticatePage(),
            '/main': (context) => WelcomeScreen(),
            '/signin': (context) => LoginScreen(),
            '/signup': (context) => SignUpScreen(),
            '/home': (context) => bottomNavigationBar(),
          }
      ),
    );
  }
}


// ignore: camel_case_types
class bottomNavigationBar extends StatefulWidget{
  const bottomNavigationBar({Key? key}) : super(key: key);

  @override
  _bottomNavigationBar createState() => _bottomNavigationBar();
}

// ignore: camel_case_types
class _bottomNavigationBar extends State<bottomNavigationBar>{
  final user = FirebaseAuth.instance.currentUser!;
  int _currentIndex = 0;

  final tabs = [
    const Center(child:Text('Feeds')),
    const Center(child:Text('Projects')),
    const Center(child:Text('Personal Spaces')),
  ];

  final List<Widget> _children = [
    const HomePage(),
    const Projects(),
    const PersonalSpaces(),
  ];

  void onTappedBar(int index){
    setState(() {
      _currentIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
      return Scaffold(
          body: _children[_currentIndex],
          bottomNavigationBar : BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.indigo,
          selectedItemColor: Colors.white70,
          unselectedItemColor: Colors.black,
          selectedFontSize: 16,
          unselectedFontSize: 13,
          onTap: onTappedBar,

          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.add_alert_outlined),
              label: "Feeds",),

            BottomNavigationBarItem(
              icon: Icon(Icons.folder_open_rounded),
              label: "Projects",),

            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              label: "PersonalSpaces",),
          ],
        )


    );
  }
}






