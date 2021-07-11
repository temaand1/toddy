import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toddyapp/components/add_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toddyapp/components/task_tile.dart';
import 'package:toddyapp/components/week_view.dart';
import 'package:toddyapp/constants.dart';
import 'package:provider/provider.dart';
import 'package:toddyapp/models/task_data.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
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
                        Navigator.pushNamed(context, 'Login');
                      },
                      child: Hero(
                        tag: 'person',
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white),
                          child: Icon(
                            Icons.today_outlined,
                            size: 38,
                            color: kMainBlue,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Text(
                        'Active Tasks  ${Provider.of<TaskData>(context).taskCount}',
                        style: TextStyle(
                            color: kMainBlue,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
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
  final _auth = FirebaseAuth.instance;
  User? loggedUser = FirebaseAuth.instance.currentUser;
  String userEmail = FirebaseAuth.instance.currentUser!.email.toString();

  @override
  void initState() {
    super.initState();
    print(loggedUser!.email);
  }

  // void getTasks() async {
  //   final tasks = await _firestore.collection('users').get();
  //   for (var task in tasks.docChanges) {
  //     print(task.doc);
  //   }
  // }

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
                  var docId = streamSnapshot.data!.docs[index].id;
                  if (streamSnapshot.data!.docs[index]['taskDate'] ==
                      DateFormat.yMd().format(DateTime.now())) {
                    return GestureDetector(
                      onTap: () {
                        print(streamSnapshot.data!.docs[index]['isDone']);
                      },
                      child: TaskTile(
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
                                  ['taskDate']
                            });
                          }

                          setState(() {
                            updateValue();
                          });
                        },
                        // onLongTap: () {
                        //   taskData.removeTask(taskData.tasks[index]);
                        //   Navigator.pop(context);
                        // },
                      ),
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
