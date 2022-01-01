import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collab/constants.dart';
import 'package:collab/project_screens/add_tasks.dart';
import 'package:collab/project_screens/task_details.dart';
import 'package:collab/widgets/provider_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:collab/project_screens/widgets/project_appbar_widget.dart';

// ignore: camel_case_types
class projectDetails extends StatefulWidget {
  final String projectID;
  const projectDetails({Key? key, required this.projectID}) : super(key: key);

  @override
  _projectDetails createState() => _projectDetails();
}

// ignore: camel_case_types
class _projectDetails extends State<projectDetails> {
  String title = '', description = '';
  int totalTask = 0;
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
              Text('Add some tasks now!', style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold, fontSize: 20)),
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
                  totalTask = docs.length;
                  return Expanded(
                  child: Align(
                  alignment: Alignment.centerRight,
                  child: Text('To do: ' + totalTask.toString(), style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold, fontSize: 20,)),
                  ),
                );
                }})
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

                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      var time = (docs[index]['timestamp'] as Timestamp).toDate();

                      return InkWell(
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
                          width: width,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey,
                                    width: 2,
                                  ))),
                          margin: EdgeInsets.only(bottom: 10),
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
                                      Text(
                                        docs[index]['task_name'],
                                        style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w500),
                                      ),
                                      // Text(
                                      //   _task['complete']==true?"Completed":"Finish by : "+_task['complete_date'],
                                      //   style: TextStyle(
                                      //       fontSize: 15,
                                      //       color: _task['complete']==true?Colors.green:Colors.red,
                                      //       fontWeight: FontWeight.bold
                                      //   ),
                                      // ),
                                      Text(
                                        docs[index]['task_desc'],
                                        maxLines: 2,
                                        style: GoogleFonts.roboto(
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Assigned to: ' + docs[index]['assignee_name'],
                                        style: GoogleFonts.roboto(
                                          fontSize: 15,
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
}
