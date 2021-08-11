import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:toddyapp/components/add_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toddyapp/components/task_tile.dart';
import 'package:toddyapp/components/week_view.dart';
import 'package:toddyapp/constants.dart';
import 'package:toddyapp/models/google_auth.dart';

import 'package:toddyapp/models/task_data.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  String userEmail = FirebaseAuth.instance.currentUser!.email.toString();
  final _auth = FirebaseAuth.instance;

  logOut() async {
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddButton(),
      backgroundColor: kMainBlue,
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _auth.currentUser != null
                            ? Navigator.pushNamed(context, 'User')
                            : Navigator.pushNamed(context, 'Login');
                      },
                      child: Hero(
                        tag: 'icon',
                        child: Container(
                          padding: EdgeInsets.all(3),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white),
                          child: Image.asset(
                            'assets/icon.png',
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        logOut();
                        GoogleAuth().signOutFromGoogle();
                        Navigator.pushNamed(context, 'Login');
                      },
                      child: Container(
                        padding: EdgeInsets.all(3),
                        child: Icon(
                          Icons.logout_sharp,
                          size: 35,
                          color: kAccentColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            WeekView(),
            Expanded(child: Taskbody())
          ],
        ),
      )),
    );
  }
}

class Taskbody extends StatefulWidget {
  @override
  _TaskbodyState createState() => _TaskbodyState();
}

class _TaskbodyState extends State<Taskbody> {
  final _firestore = FirebaseFirestore.instance;

  User? loggedUser = FirebaseAuth.instance.currentUser;
  String userEmail = FirebaseAuth.instance.currentUser!.email.toString();

  @override
  void initState() {
    super.initState();
    print(loggedUser!.email);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: StreamBuilder(
          stream: _firestore.collection('$userEmail').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  // ignore: unused_local_variable
                  var docId = streamSnapshot.data!.docs[index].id;
                  if (streamSnapshot.data!.docs[index]['taskDate'] ==
                      Provider.of<TaskData>(context).dayToShow) {
                    return GestureDetector(
                      onTap: () {
                        print(streamSnapshot.data!.docs[index]['isDone']);
                      },
                      child: TaskTile(
                          codePoint: streamSnapshot.data!.docs[index]['icon'],
                          text: streamSnapshot.data!.docs[index]['taskName'],
                          isChecked: streamSnapshot.data!.docs[index]['isDone'],
                          onTap: (bool? newValue) {
                            String currentTaskName =
                                streamSnapshot.data!.docs[index]['taskName'];

                            void updateValue() async {
                              final currentTask = _firestore
                                  .collection('$userEmail')
                                  .doc("$currentTaskName");
                              return await currentTask.set({
                                'isDone': !streamSnapshot.data!.docs[index]
                                    ['isDone'],
                                'taskName': streamSnapshot.data!.docs[index]
                                    ['taskName'],
                                'taskDate': streamSnapshot.data!.docs[index]
                                    ['taskDate'],
                                'icon': streamSnapshot.data!.docs[index]
                                    ['icon'],
                              });
                            }

                            setState(() {
                              updateValue();
                            });
                          },
                          onLongTap: () {
                            String currentTaskName =
                                streamSnapshot.data!.docs[index]['taskName'];

                            void updateValue() async {
                              final currentTask = _firestore
                                  .collection('$userEmail')
                                  .doc("$currentTaskName");
                              return await currentTask.delete();
                            }

                            setState(() {
                              updateValue();
                              Navigator.pop(context);
                            });
                          }),
                    );
                  }
                  return Container();
                },
                itemCount: streamSnapshot.data!.docs.length,
              );
            } else
              return Center(child: CircularProgressIndicator.adaptive());
          }),
    );
  }
}
