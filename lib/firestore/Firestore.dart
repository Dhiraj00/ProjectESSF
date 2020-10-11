import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essf/adminscreens/adminpage.dart';
import 'package:essf/platform_alert.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DatabaseManager {
  final CollectionReference users = Firestore.instance.collection('users');
  final CollectionReference events = Firestore.instance.collection('events');

  Future<void> createEvents(
      String title,
      String subtitle,
      String phone,
      String lat,
      String long,
      String description,
      DateTime date,
      String image) async {
    return await events.document(title).setData({
      'title': title,
      'subtitle': subtitle,
      'lat': lat,
      'long': long,
      'phone': phone,
      'description': description,
      'date': date,
      'image': image,
    });
  }

  Future getEventsList() async {
    List itemsList = [];
    try {
      await events.getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((element) {
          print(element);
          itemsList.add(element.data);
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> createUserData(
      String name, String email, String uid, String url) async {
    return await users
        .document(uid)
        .setData({'name': name, 'email': email, 'uid': uid, 'url': url});
  }

  Future updateUserList(
      String name, String email, String uid, String role) async {
    Firestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .getDocuments()
        .then((querySnapshot) {
      if (querySnapshot.documents[0].exists) {
        querySnapshot.documents[0].reference.updateData(
            {'name': name, 'email': email, 'uid': uid, 'role': role});
      }
    });
  }

  Future updateUserImage(String email, String url) async {
    Firestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .getDocuments()
        .then((querySnapshot) {
      if (querySnapshot.documents[0].exists) {
        querySnapshot.documents[0].reference.updateData({'url': url});
      }
    });
  }

  Future<void> deleteData(String name, String email, uid) async {
    Firestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .getDocuments()
        .then((querySnapshot) {
      if (querySnapshot.documents[0].exists) {
        querySnapshot.documents[0].reference.delete();
      }
    });
  }

  Future getUsersList() async {
    List itemsList = [];
    try {
      await users.getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((element) {
          print(element);
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
      print(user.email);
      Firestore.instance
          .collection('users')
          .where('email', isEqualTo: user.email)
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
