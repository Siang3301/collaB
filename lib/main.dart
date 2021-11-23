import 'package:collab/initial_screens/Welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import './app_screens/HomePage.dart';
import './app_screens/Projects.dart';
import './app_screens/PersonalSpaces.dart';

void main() {
  runApp(Collab());
}

class Collab extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home : WelcomeScreen(),
    );
  }
}

class bottomNavigationBar extends StatefulWidget{
  const bottomNavigationBar({Key? key}) : super(key: key);

  _bottomNavigationBar createState() => _bottomNavigationBar();
}

class _bottomNavigationBar extends State<bottomNavigationBar>{

  int _currentIndex = 0;

  final tabs = [
    Center(child:Text('Feeds')),
    Center(child:Text('Projects')),
    Center(child:Text('Personal Spaces')),
  ];

  final List<Widget> _children = [
    HomePage(),
    Projects(),
    PersonalSpaces(),
  ];

  void onTappedBar(int index){
    setState(() {
      _currentIndex = index;
    });
  }


  Widget build(BuildContext context) {
      return new Scaffold(
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

          items: [
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






