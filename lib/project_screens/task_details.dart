import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collab/constants.dart';
import 'package:collab/project_screens/widgets/task_appbar_widget.dart';
import 'package:collab/widgets/provider_widgets.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class taskDetails extends StatefulWidget {
  final String title, description, taskID, projectID;
  const taskDetails({Key? key, required this.title, required this.description, required this.taskID, required this.projectID}) : super(key: key);

  @override
  _taskDetails createState() => _taskDetails();
}

// ignore: camel_case_types
class _taskDetails extends State<taskDetails> {
  int trueCounter = 0; int temp = 0;
  bool isLoading = false;
  Map<String, dynamic>? assignee;
  Map<String, dynamic>? userMap;
  List<Map<String, dynamic>> membersList = [];
  var time = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  List<bool> _isChecked = [];
  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    descriptionController.text = widget.description;
    titleController.text = widget.title;
    getCurrentTaskDetails();
    getCurrentMembers();
  }

  void getCurrentTaskDetails() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    await db
        .collection('projects')
        .doc(widget.projectID)
        .collection('tasks')
        .doc(widget.taskID)
        .get()
        .then((value) {
      setState(() {
          assignee = value.data();
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
    _isChecked = List<bool>.filled(membersList.length, false);
  }

  void onResultSelected(bool selected, String uid) async{
    FirebaseFirestore db = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    await db
        .collection('users_data')
        .where("uid", isEqualTo: uid)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
      // ignore: avoid_print
      print(userMap);
    });

    if (selected == true) {
      setState(() {
        assignee = userMap;
      });
    }else{
      setState(() {
      });
    }
  }

  Map<String, dynamic> updateTask() => {
    'task_name': titleController.text,
    'task_desc': descriptionController.text,
    'assignee_name' : userMap?['username'] ?? assignee?['assignee_name'],
    'assignee_email': userMap?['email'] ?? assignee?['assignee_email'],
    'time': 'updated on: '+ time.toString(),
    'timestamp': time,
  };

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of(context)!.auth;
    final db = Provider.of(context)!.db;
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: buildAppBar(context, widget.projectID, widget.taskID),
      body: Form(
        key: _formKey,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: width,
              decoration: BoxDecoration(
                  color: Color(0xFFF1F4F9),
                  border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: kPrimaryLightColor,
                      ))),
              height: 50,
              padding: EdgeInsets.only(top: 5),
              child: SizedBox(
                  child:Container(
                      width: size.width * 0.8,
                      margin: EdgeInsets.only(left: 20),
                      child: TextFormField(
                    // Handles Form Validation
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your title';
                        }
                        return null;
                      },
                      controller: titleController,
                        style: TextStyle(fontSize: 20, fontFamily: 'Raleway', fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter task title',
                      ),
                    )))),
        Container(
          width: width,
          decoration: BoxDecoration(
              color: Color(0xFFF1F4F9),
              border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: kPrimaryLightColor,
                  ))),
          height: 250,
          child: SizedBox(
              child:Container(
                width: size.width * 0.8,
                margin: EdgeInsets.only(left: 20),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                // Handles Form Validation
                validator: (value) {
                if (value == null || value.isEmpty) {
                return 'Please enter your description';
                 }
                return null;
                 },
                controller: descriptionController,
                style: TextStyle(fontSize: 17, fontFamily: 'Raleway', fontWeight: FontWeight.normal),
                decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter task description',
                ),
                ))
                ),
          ),
          SizedBox(height: 10),
          Container(
              alignment: Alignment.centerLeft,
              width: width,
              decoration: BoxDecoration(
                  color: Color(0xFFF1F4F9),
                  border: Border.all(
                        width: 1,
                        color: kPrimaryLightColor,
                      )),
              height: 50,
              padding: EdgeInsets.only(top: 5),
              child: TextButton.icon(
                icon: Icon(Icons.add, color: Colors.indigoAccent),
                label: Text('Add attachment', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Raleway')),
                onPressed: (){
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (BuildContext context) => WelcomeScreen()),
                  //     ModalRoute.withName('/')
                  // );
                },
              ),
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.topLeft,
            width: width,
            decoration: BoxDecoration(
                color: Color(0xFFF1F4F9),
                border: Border.all(
                  width: 1,
                  color: kPrimaryLightColor,
                )),
            height: 100,
            padding: EdgeInsets.only(top: 15,left: 10),
            child: Column(
              children:[
                Row(
                  children:[
                    Icon(
                    Icons.person, color: Colors.indigoAccent,
                     ),
                Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: Text(
                  'Assignee',
                  style: TextStyle(fontSize: 20, color: Colors.black,fontFamily: 'Raleway',fontWeight: FontWeight.bold),
                )),
                ]
                ),
              SizedBox(height: 5),
              Row(
                children:[
                  Icon(
                    Icons.email, color: Colors.indigoAccent,
                  ),
                Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      assignee?['assignee_email'] ?? assignee?['email'] ?? 'Anonymous',
                      style: TextStyle(fontSize: 15, color: Colors.black,fontFamily: 'Raleway',fontWeight: FontWeight.bold),
                    )),
                Container(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        primary: Colors.blueGrey,
                      ),
                      icon: Icon(Icons.keyboard_arrow_right),
                      label: Text('update'),
                      onPressed: () {
                          showDialog(
                          context: context,
                          builder: (context) {
                          return StatefulBuilder( // StatefulBuilder
                          builder: (context, setState) {
                          return Dialog(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                    margin: EdgeInsets.only(top:15),
                                    padding: EdgeInsets.only(left:10,right:10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                color: kPrimaryLightColor,
                                                width: 2,
                                              ))),
                                    child:Text(
                                      'Change Assignee',
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.black, fontFamily: 'Raleway', fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.only(top:20),
                                  child: ListView.builder(
                                      itemCount: membersList.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Container(
                                          child: CheckboxListTile(
                                            value: _isChecked[index],
                                            onChanged: (newValue) {
                                              setState(() {
                                                if (newValue == true) {
                                                  trueCounter = trueCounter + 1;
                                                  if (trueCounter == 1) {
                                                    temp = index;
                                                    _isChecked[index] =
                                                    newValue!;
                                                  }
                                                  else if (trueCounter > 1) {
                                                    _isChecked[temp] = false;
                                                    temp = index;
                                                    _isChecked[index] =
                                                    newValue!;
                                                    trueCounter =
                                                        trueCounter - 1;
                                                  }
                                                }
                                                else {
                                                  trueCounter = trueCounter - 1;
                                                  _isChecked[index] = newValue!;
                                                }
                                              });
                                              onResultSelected(
                                                  _isChecked[index],
                                                  membersList[index]['uid']);
                                              print(newValue);
                                            },
                                            title: Text(
                                                membersList[index]['username']),
                                            subtitle: Text(
                                                membersList[index]['email']),
                                            secondary: Icon(
                                                Icons.person_rounded,
                                                color: kPrimaryLightColor),
                                          ),
                                        );
                                      }),
                                  ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xFFfab82b), padding: EdgeInsets.symmetric(horizontal: 30)),
                                  child: Text(
                                    'Done',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(height: 20)
                              ],
                            ),
                          );
                        });});
                      },
                    )),
                  ]
                 ),
                ]
               ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 50),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async{
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          await FirebaseFirestore.instance
                              .collection('projects')
                              .doc(widget.projectID)
                              .collection('tasks')
                              .doc(widget.taskID)
                              .update(updateTask());
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Task updated!'),));
                        }
                      },
                      child: const Text(
                        'Update task',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  )))
        ],
        ),
      ),
    );
  }
}
