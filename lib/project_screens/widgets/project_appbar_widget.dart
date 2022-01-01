import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collab/main.dart';
import 'package:collab/project_screens/project_settings.dart';
import 'package:collab/search_appbar_page.dart';
import 'package:collab/widgets/provider_widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

AppBar buildAppBar(BuildContext context, String title, String description, String projectID, List membersList) {
  return AppBar(
    iconTheme: IconThemeData(
        color: Colors
            .black), // set backbutton color here which will reflect in all screens.
    leading: BackButton(),
    backgroundColor: Colors.indigo,
    title: Text(title, style:TextStyle(fontFamily: 'Raleway')),
    elevation: 0,
      actions: [
        Theme(data: Theme.of(context).copyWith(
            dividerColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.white)
        ),
          //list if widget in appbar actions
          child:PopupMenuButton<int>(//don't specify icon if you want 3 dot menu
            color: Colors.blue,
            onSelected: (item) => onClicked(context, item, projectID, membersList, title, description),
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Text("Project settings",style: TextStyle(color: Colors.black, fontFamily: 'Raleway'),),
              ),
              PopupMenuDivider(),
              PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: const [
                    Icon(Icons.search, color: Colors.white),
                    SizedBox(width: 8),
                    Text("Search",style: TextStyle(color: Colors.black, fontFamily: 'Raleway'),),
                  ],
                ),
              ),
              PopupMenuDivider(),
              PopupMenuItem<int>(
                value: 2,
                child: Row(
                  children: const [
                    Icon(Icons.delete, color: Colors.black),
                    SizedBox(width: 8),
                    Text("Delete Project",style: TextStyle(color: Colors.black, fontFamily: 'Raleway'),),
                  ],
                ),
              ),
            ],
          ),),
      ]
  );
}

void onClicked(BuildContext context, int item, projectID, membersList, title, description){

  Future removeProject() async{
    final db = FirebaseFirestore.instance;
    //execute delete from project DB (only admin can execute/ not function yet) -->


    //execute delete from project for every user's view
    for(int i = 0; i<membersList.length ; i++) {
      final uid = membersList[i]['uid'];
      await db
          .collection('users_data')
          .doc(uid)
          .collection('users_project')
          .doc(projectID)
          .delete();
    }

    //execute delete from project project -> tasks
    await db
        .collection('projects')
        .doc(projectID)
        .collection('tasks')
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs){
        ds.reference.delete();
      }});

    //remove projectID
    await db
        .collection('projects')
        .doc(projectID)
        .delete();
  }

  switch(item){
    case 0 :
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => projectSettings(title:title, description:description, projectID:projectID)),
      );
      break;

    case 1 :
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => LocalSearchAppBarPage()),
      );
      break;

  case 2 :
      removeProject();
      Navigator.of(context).pop(
        MaterialPageRoute(builder: (context) => bottomNavigationBar()),
      );
      Fluttertoast.showToast(msg: 'Project successfully deleted');
      break;
  }
}

