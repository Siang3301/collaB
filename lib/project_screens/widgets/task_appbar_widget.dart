import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collab/project_screens/project_details.dart';
import 'package:collab/search_appbar_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

AppBar buildAppBar(BuildContext context, String projectID, String taskID) {
  return AppBar(
    iconTheme: IconThemeData(
        color: Colors
            .black), // set backbutton color here which will reflect in all screens.
    leading: BackButton(),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      Theme(data: Theme.of(context).copyWith(
          dividerColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black)
      ),
        //list if widget in appbar actions
        child:PopupMenuButton<int>(//don't specify icon if you want 3 dot menu
          color: Colors.blue,
          onSelected: (item) => onClicked(context, item, projectID, taskID),
          itemBuilder: (context) => [
            PopupMenuItem<int>(
              value: 0,
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
              value: 1,
              child: Row(
                children: const [
                  Icon(Icons.delete, color: Colors.black),
                  SizedBox(width: 8),
                  Text("Delete task",style: TextStyle(color: Colors.black, fontFamily: 'Raleway'),),
                ],
              ),
            ),
          ],
        ),),
    ],
  );
}

void onClicked(BuildContext context, int item, projectID, taskID){

  Future removeTask() async{
    final db = FirebaseFirestore.instance;
    //execute
    await db
        .collection('projects')
        .doc(projectID)
        .collection('tasks')
        .doc(taskID)
        .delete();
  }

  switch(item){
    case 0 :
      Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => LocalSearchAppBarPage()),
    );
    break;

    case 1 :
      removeTask();
      Navigator.of(context).pop(
      MaterialPageRoute(builder: (context) => projectDetails(projectID: projectID)),
      );
      Fluttertoast.showToast(
        backgroundColor: Colors.grey,
        msg: "Task successfully deleted",
        gravity: ToastGravity.CENTER,
        fontSize: 16.0,
      );
    break;
  }
}

