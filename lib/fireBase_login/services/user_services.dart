import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sheet_widget_demo/model/userModel.dart';

class UserServices {
  CollectionReference userTable = FirebaseFirestore.instance.collection("user");
  var users = FirebaseAuth.instance.currentUser;

  Future createUser(UserData userData) async {
    try {
      await userTable.doc(userData.userID).set(userData.toJson());
    } catch (e) {
      Fluttertoast.showToast(msg: e.message());
    }
  }
}
