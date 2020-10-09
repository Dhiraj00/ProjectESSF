import 'package:essf/firestore/Firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppUsers extends StatefulWidget {
  @override
  _AppUsersState createState() => _AppUsersState();
}

class _AppUsersState extends State<AppUsers> {
  TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  TextEditingController _roleController = TextEditingController();
  List userProfilesList = [];
  String userID = "";
  @override
  void initState() {
    super.initState();
    fetchUserInfo();
    fetchdatabaseList();
  }

  fetchUserInfo() async {
    FirebaseUser getUser = await FirebaseAuth.instance.currentUser();
    userID = getUser.uid;
  }

  fetchdatabaseList() async {
    dynamic resultant = await DatabaseManager().getUsersList();
    if (resultant == null) {
      print('unnable to retrieve');
    } else {
      setState(() {
        userProfilesList = resultant;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App users'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(Icons.fullscreen_exit),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: userProfilesList.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  onTap: () {
                    openDialogueBox(context, userProfilesList[index]['email'],
                        userProfilesList[index]['uid']);
                  },
                  title: Text(userProfilesList[index]['name']),
                  subtitle: Text(userProfilesList[index]['email']),
                  leading: CircleAvatar(
                    radius: 30,
                    child:ClipOval(
                     child: SizedBox(
                       height:180,
                       width:180,
                    child: (userProfilesList[index]['url'] == null)
                        ? Image(image: AssetImage('assets/Givemeshelter.png',),fit: BoxFit.fill,)
                        : Image.network(userProfilesList[index]['url'],fit: BoxFit.fill,),
                  ),)),
                  trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        DatabaseManager().deleteData(
                            userProfilesList[index]['name'],
                            userProfilesList[index]['email'],
                            userProfilesList[index]['uid']);
                      }),
                ),
              );
            }),
      ),
    );
  }

  openDialogueBox(BuildContext context, String email, String uid) {
    _emailController.text = email;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit User Details'),
            content: Container(
                height: 150,
                child: Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(hintText: 'Name'),
                    ),
                    TextField(
                      controller: _roleController,
                      decoration: InputDecoration(hintText: 'role'),
                    ),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(hintText: 'Email'),
                    ),
                  ],
                )),
            actions: [
              FlatButton(
                  onPressed: () {
                    DatabaseManager().updateUserList(
                        _nameController.text, email, _roleController.text, uid);
                  },
                  child: Text('Submit')),
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'))
            ],
          );
        });
  }
}
