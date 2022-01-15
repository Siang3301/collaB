import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:collab/constants.dart';

class EventModel{
  final String? name;
  final String? desc;
  final DateTime? due;
  final String? assignee_name;
  final String? assignee_email;
  final String? projectID;
  final String? taskID;
  final bool? status;

  EventModel({this.name, this.desc, this.due, this.assignee_name, this.assignee_email, this.status, this.projectID, this.taskID});

  EventModel copyWith({
    String? name,
    String? desc,
    DateTime? due,
    String? assignee_name,
    String? assignee_email,
    bool? status,
    String? projectID,
    String? taskID,
  }) {
    return EventModel(
      name: name ?? this.name,
      desc: desc ?? this.desc,
      assignee_name: assignee_name ?? this.assignee_name,
      due: due ?? this.due,
      assignee_email: assignee_email ?? this.assignee_email,
      status: status ?? this.status,
      projectID: projectID ?? this.projectID,
      taskID: taskID ?? this.taskID,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'desc': desc,
      'due': due,
      'assignee_name': assignee_name,
      'assignee_email': assignee_email,
      'status': status,
      'projectID': projectID,
      'taskID': taskID
    };
  }


  factory EventModel.fromMap(Map<String, dynamic> map) {

    return EventModel(
      name: map['task_name'],
      desc: map['task_desc'],
      due: DateTime.parse(map['due_date']),
      assignee_name: map['assignee_name'],
      assignee_email: map['assignee_email'],
      status: map['complete'],
      projectID: map['projectID'],
      taskID: map['taskID']
    );
  }
  factory EventModel.fromDS(String id, Map<String, dynamic> data) {

    return EventModel(
      name: data['task_name'],
      desc: data['task_desc'],
      due: DateTime.parse(data['due_date']),
      assignee_name: data['assignee_name'],
      assignee_email: data['assignee_email'],
      status: data['complete'],
      projectID: data['projectID'],
      taskID: data['taskID']
    );
  }

  factory EventModel.fromJson(String source) =>
      EventModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EventModel(title: $name, assignee_name: $assignee_name,'
        ' description: $desc, due: $due, assignee_email: $assignee_email,'
        ' status: $status, projectID: $projectID, taskID: $taskID)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is EventModel &&
        o.name == name &&
        o.desc == desc &&
        o.due == due &&
        o.assignee_name == assignee_name &&
        o.assignee_email == assignee_email &&
        o.status == status &&
        o.projectID == projectID &&
        o.taskID == taskID;
  }

  @override
  int get hashCode {
    return name.hashCode ^
    desc.hashCode ^
    due.hashCode ^
    assignee_name.hashCode ^
    assignee_email.hashCode ^
    status.hashCode ^
    projectID.hashCode ^
    taskID.hashCode;
  }
}