import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collab/constants.dart';
import 'package:collab/project_screens/add_tasks.dart';
import 'package:collab/project_screens/task_details.dart';
import 'package:collab/project_screens/widgets/dismissible_widget.dart';
import 'package:collab/widgets/provider_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:collab/project_screens/widgets/project_appbar_widget.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class projectDetails extends StatefulWidget {
  final String projectID;
  const projectDetails({Key? key, required this.projectID}) : super(key: key);

  @override
  _projectDetails createState() => _projectDetails();
}

// ignore: camel_case_types
class _projectDetails extends State<projectDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String title = '', description = '';
  List<Map<String, dynamic>> membersList = [];

  @override
  void initState() {
    super.initState();
    getCurrentProjectDetails();
    getCurrentMembers();
  }

  void getCurrentProjectDetails() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    await db
        .collection('users_data')
        .doc(auth.currentUser!.uid)
        .collection('users_project')
        .doc(widget.projectID)
        .get()
        .then((value) {
      setState(() {
         title = value['title'];
         description = value['description'];
      });
    });
  }

  void getCurrentMembers() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    await db
        .collection('projects')
        .doc(widget.projectID)
        .get()
        .then((value) {
      setState(() {
        for(int i = 0; i<value.data()?["members"].length ; i++) {
          membersList.add({
            "username": value.data()!["members"][i]["username"].toString(),
            "email": value.data()!["members"][i]["email"].toString(),
            "uid": value.data()!["members"][i]["uid"].toString(),
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of(context)!.auth;
    final db = Provider.of(context)!.db;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white70.withOpacity(0.93),
      appBar: buildAppBar(context, title, description, widget.projectID, membersList),
      body: SingleChildScrollView(
        child : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(15),
            height: 60,
            width: width,
            color: kPrimaryColor,
            child:Row( children:[
              StreamBuilder<QuerySnapshot>(
                stream: db
                    .collection('projects')
                    .doc(widget.projectID)
                    .collection('tasks')
                    .snapshots(),
                builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                 return Center(
                  child: CircularProgressIndicator(),
                  );
                  } else {
                  var docs = snapshot.data!.docs;
                  int totalTask = docs.length;
                  int toDo = 0; int done = 0;
                  for(int i = 0; i<docs.length; i ++){
                    if(docs[i]['complete'] == true){
                      done++;
                    }
                    else{
                      toDo++;
                    }
                  }
                  return Flexible(
                    child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                     Align(
                     child:RichText(text:TextSpan(children:[
                      totalTask == 0 ?
                      TextSpan(text: 'Add some task now!', style: TextStyle(color: Colors.black, fontFamily: 'Raleway', fontWeight: FontWeight.bold, fontSize: 18))
                          :
                      TextSpan(text: 'Total Tasks: ' + totalTask.toString(), style: TextStyle(color: Colors.black, fontFamily: 'Raleway', fontWeight: FontWeight.bold, fontSize: 18)),
                    ])),),
                    Align(
                    child:RichText(text: TextSpan( children: [
                    TextSpan(text: 'To Do: ' + toDo.toString() + '\t\t',style: TextStyle(color: Colors.black, fontFamily: 'Raleway', fontWeight: FontWeight.bold, fontSize: 18)),
                    TextSpan(text: 'Done: ' + done.toString(),style: TextStyle(color: Colors.black,  fontFamily: 'Raleway', fontWeight: FontWeight.bold, fontSize: 18)),],),)
                  )]));
                }}),
            ]
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder<QuerySnapshot>(
              stream: db
                  .collection('projects')
                  .doc(widget.projectID)
                  .collection('tasks')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  var docs = snapshot.data!.docs;

                  return ListView.separated(
                    itemCount: docs.length,
                    separatorBuilder: (context, index) => Container(
                                                    decoration: BoxDecoration(
                                                    border: Border(
                                                    bottom: BorderSide(
                                                    color: Colors.grey,
                                                    width: 0.5,
                                                  ))),),
                    itemBuilder: (context, index) {
                    DateTime due = DateTime.parse(docs[index]['due_date']);

                      return DismissibleWidget(
                        item: docs,
                        child: buildListTile(docs, index, due),
                        onDismissed: (direction) =>
                            dismissItem(context, index, direction, docs[index].id),
                      );
                    },
                  );
                }
              },
            ),
            // color: Colors.red,
          ),
        ],
      ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddTasks(projectID:widget.projectID)));
          }),
    );
  }

  Widget buildListTile(final docs, int index, DateTime due) => InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => taskDetails(
                title: docs[index]['task_name'],
                description: docs[index]['task_desc'],
                projectID: widget.projectID,
                taskID: docs[index].id,
              )));
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
        border: Border(
        bottom: BorderSide(
            color: Colors.grey,
            width: 0.5,
        ))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Center(
              child: Text(
                docs[index]['task_name'][0],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25
                ),
              ),
            ),
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kPrimaryLightColor
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  docs[index]['complete'] == false ? Text(
                    docs[index]['task_name'],
                    style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w500),
                  ):
                  Text(
                    docs[index]['task_name'],
                    style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w500, decoration: TextDecoration.lineThrough),
                  ),

                  docs[index]['complete'] == false ? Text(
                    docs[index]['task_desc'],
                    maxLines: 2, style: GoogleFonts.roboto(fontSize: 15),
                  ):
                  Text(
                    docs[index]['task_desc'],
                    maxLines: 2, style: GoogleFonts.roboto(fontSize: 15,decoration: TextDecoration.lineThrough),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Assigned to: ' + docs[index]['assignee_name'],
                    style: GoogleFonts.roboto(
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    docs[index]['complete']==true?"Completed" : "Due on : " + DateFormat.yMd().add_jm().format(due),
                    style: GoogleFonts.roboto(
                        fontSize: 15,
                        color: docs[index]['complete'] == true?Colors.green : Colors.red,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );

  void dismissItem(BuildContext context, int index, DismissDirection direction, String taskID) {
    switch (direction) {
      case DismissDirection.endToStart: //1
        try {
            deleteConfirmation(context, widget.projectID, taskID);
        }catch(e){
          print(e);
        }
        break;
      case DismissDirection.startToEnd: //2
        try {
            archiveConfirmation(context, widget.projectID, taskID);
        }catch(e){
          print(e);
        }
        break;
      default:
        break;
    }
  }

  archiveConfirmation(BuildContext context, projectID, taskID) {

    // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: Text("Cancel"),
      onPressed:  () {
        setState(() {
          Navigator.pop(context);
        });
      },
    );
    Widget continueButton = ElevatedButton(
      child: Text("Yes"),
      onPressed:  () {
        try{
          archiveTask(projectID, taskID);
        }catch(e){
         print(e);
        }
          Future.delayed(Duration.zero, () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Task successfully archived!'),));
          });
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Archive Confirmation"),
      content: Text("Are you sure to archive this task?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  deleteConfirmation(BuildContext context, projectID, taskID) {
    final db = Provider.of(context)!.db;
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: Text("Cancel"),
      onPressed:  () {
        setState(() {
          Navigator.pop(context);
        });
      },
    );
    Widget continueButton = ElevatedButton(
      child: Text("Yes"),
      onPressed:  () async{
        try{
          await db
              .collection('projects')
              .doc(projectID)
              .collection('tasks')
              .doc(taskID)
              .delete();

          //delete task from eventDB on every user that terlibat in project
          for(int i = 0; i<membersList.length ; i++) {
            final uid = membersList[i]['uid'];
            await db.collection('users_data')
                .doc(uid)
                .collection('event_data')
                .doc(taskID)
                .delete();
          }
        }catch(e){
          print(e);
        }
        setState(() {
          Future.delayed(Duration.zero, () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Task successfully deleted!'),));
          });
        });
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Confirmation"),
      content: Text("Are you sure to delete this task?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  archiveTask(String projectID, String taskID) async {
    final db = Provider.of(context)!.db;
    var time = DateTime.now();

    for(int i = 0; i<membersList.length ; i++) {
      final uid = membersList[i]['uid'];
      var oldCollection = db.collection('users_data').doc(uid).collection('event_data').doc(taskID);
      var newCollection = db.collection('projects_logDB').doc(uid).collection('project_archive').doc(projectID).collection('task_archive').doc(oldCollection.id);

      DocumentSnapshot snapshot = await oldCollection.get().then((docSnapshot){
        if (docSnapshot.exists) {
          // document id does exist
          print('Successfully found document');
          newCollection
              .set({
            'assignee_email': docSnapshot['assignee_email'],
            'assignee_name': docSnapshot['assignee_name'],
            'complete': docSnapshot['complete'],
            'due_date': docSnapshot['due_date'],
            'task_desc': docSnapshot['task_desc'],
            'task_name': docSnapshot['task_name'],
            'time':  'archived on: ' + time.toString(),
            'timestamp':  time,
          })
              .then((value) => print("document moved to different collection"))
              .catchError((error) => print("Failed to move document: $error")).then((value) => ({

            oldCollection
                .delete()
                .then((value) => print("document removed from old collection"))
                .catchError((error) {
              newCollection.delete();
              print("Failed to delete document: $error");

            })
          }));
        } else {
          //document id doesnt exist
          print('Failed to find document id');
        }
      });
    }
    //execute DB task deletion
    await db
        .collection('projects')
        .doc(projectID)
        .collection('tasks')
        .doc(taskID)
        .delete();
  }


}
