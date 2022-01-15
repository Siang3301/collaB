import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collab/constants.dart';
import 'package:get/get.dart';


class DataController extends GetxController {
  Future getData() async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot =
    await firebaseFirestore.collection('users_data').doc(getPath()).collection('event_data').get();
    return snapshot.docs;
  }

  Future queryData(String queryString) async {
    return FirebaseFirestore.instance.collection('users_data').doc(getPath()).collection('event_data').where('task_name', isEqualTo: queryString).get();
  }
}

