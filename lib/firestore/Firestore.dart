import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essf/adminscreens/adminpage.dart';
import 'package:essf/platform_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DatabaseManager {
  final CollectionReference users = Firestore.instance.collection('users');

  Future<void> createUserData(String name, String email, String uid) async {
    return await users.document(uid).setData({'name': name, 'email': email});
  }

  Future updateUserList(String name, String email, String uid) async {
    return await users
        .document(uid)
        .updateData({'name': name, 'email': email, 'uid': uid});
  }

  Future<void> deleteData(String name, String email, String uid) async {
    return await Firestore.instance
        .collection('users')
        .document(uid)
        .delete()
        .catchError((e) {
      print('e');
    });
  }

  Future getUsersList() async {
    List itemsList = [];
    try {
      await users.getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((element) {
          itemsList.add(element.data);
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

class UserManagement {
  authorizeAdmin(BuildContext context) {
    FirebaseAuth.instance.currentUser().then((user) {
      Firestore.instance
          .collection('users')
          .where('uid', isEqualTo: user.uid)
          .getDocuments()
          .then((querySnapshot) {
        if (querySnapshot.documents[0].exists) {
          if (querySnapshot.documents[0].data['role'] == 'admin') {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => AdminHome()));
                    print(querySnapshot.documents[0].data['role']);
          } else {
            PlatformAlertDialog(
                    title: 'Error',
                    content: 'You are not authorized!',
                    cancelActionText: null,
                    defaultActionText: 'ok')
                .show(context);
          }
        }
      });
    });
  }
}
