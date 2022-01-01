import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collab/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:collab/widgets/provider_widgets.dart';
import 'package:uuid/uuid.dart';

class AddTasks extends StatefulWidget {
  final String projectID;
  const AddTasks({Key? key, required this.projectID}) : super(key: key);

  @override
  _AddTasks createState() => _AddTasks();
}

class _AddTasks extends State<AddTasks> {
  final _formKey = GlobalKey<FormState>();
  int trueCounter = 0; int temp = 0;
  bool isLoading = false; List<bool> _isChecked = [];
  Map<String, dynamic>? userMap;
  List<Map<String, dynamic>> assignee = [];
  List<Map<String, dynamic>> membersList = [];
  TextEditingController taskName = TextEditingController();
  TextEditingController taskDesc = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentMembers();
  }

  //trigger add
  addTasks(String projectID) async {
    final auth = Provider.of(context)!.auth;
    final db = Provider.of(context)!.db;
    var time = DateTime.now();

    setState(() {
      isLoading = true;
    });

    String taskID = Uuid().v1();

    //create new task to selected projectDB
    await db.collection('projects')
            .doc(projectID)
            .collection('tasks')
            .doc(taskID)
            .set({
      "task_name": taskName.text,
      "task_desc": taskDesc.text,
      "assignee_name" : assignee[0]['username'],
      "assignee_email": assignee[0]['email'],
      'time': time.toString(),
      'timestamp': time,
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
        assignee.add({
          "username": userMap!['username'],
          "email": userMap!['email'],
          "uid": userMap!['uid'],
        });
        userMap = null;
      });
    }else{
      setState(() {
        assignee.removeLast();
        userMap = null;
      });
    }
  }

  void onRemoveMembers(int index) {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (membersList[index]['uid'] != auth.currentUser!.uid) {
      setState(() {
        membersList.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final auth = Provider.of(context)!.auth;
    final db = Provider.of(context)!.db;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(backgroundColor: Colors.indigo, title: Text('New Tasks')),
      body: Form(
          key: _formKey,
          child:SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your title';
                  }
                  return null;
                },
                controller: taskName,
                decoration: InputDecoration(
                    labelText: 'Enter Title', border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your description';
                  }
                  return null;
                },
                controller: taskDesc,
                maxLines: 5,
                decoration: InputDecoration(
                    alignLabelWithHint: true,
                    labelText: 'Enter Description',
                    border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),
              Divider(
                  color: Colors.grey
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.only(bottom: 20),
                child: Text('Assign member', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Raleway'),),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: ListView.builder(
                      itemCount: membersList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          value: _isChecked[index],
                          onChanged:(newValue){
                            setState(() {
                                if(newValue == true){
                                  trueCounter = trueCounter + 1;
                                  if(trueCounter == 1) {
                                    temp = index;
                                    _isChecked[index] = newValue!;
                                  }
                                  else if(trueCounter > 1){
                                    _isChecked[temp] = false;
                                    temp = index;
                                    _isChecked[index] = newValue!;
                                    trueCounter = trueCounter - 1;
                                  }
                                }
                                else{
                                  trueCounter = trueCounter - 1;
                                  _isChecked[index] = newValue!;
                                }
                            });
                            onResultSelected(_isChecked[index], membersList[index]['uid']);
                            print(newValue);
                        },
                        title: Text(membersList[index]['username']),
                        subtitle: Text(membersList[index]['email']),
                        secondary: Icon(Icons.person_rounded, color: kPrimaryLightColor),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: size.height / 20,
                  ),
                ],
              ),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor:
                    MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.purple.shade100;
                          }
                          return Theme.of(context).primaryColor;
                        })),
                    child: Text(
                      'Add Task',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        addTasks(widget.projectID);
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                          backgroundColor: Colors.grey,
                          msg: "Task successfully created",
                          gravity: ToastGravity.CENTER,
                          fontSize: 16.0,
                        );
                      }
                    },
                  ))
            ],
          ))),
    );
  }
}