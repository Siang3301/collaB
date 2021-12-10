import 'package:flutter/material.dart';

class Projects extends StatefulWidget{
  const Projects({Key? key}) : super(key: key);

  @override
  _ProjectsState createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar : AppBar(
          title : const Text("Projects"),
          backgroundColor: Colors.indigo,
          automaticallyImplyLeading: false,
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
                child : Text("Projects page."),
          )
        )
    );
  }
}