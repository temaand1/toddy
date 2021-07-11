import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toddyapp/models/task_data.dart';

import '../constants.dart';

class AddButton extends StatefulWidget {
  @override
  _AddButtonState createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final bool taskInit = false;
  User? loggedUser;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
    print(loggedUser!.email);
  }

  void getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    loggedUser = user;
  }

  @override
  Widget build(BuildContext context) {
    String newTaskTitle = "";
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton(
        backgroundColor: kAccentColor,
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff757575)),
                      color: Color(0xff757575),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          color: Colors.white),
                      child: Padding(
                        padding: kMainPadding,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                'Add Task',
                                style:
                                    TextStyle(fontSize: 26, color: kMainBlue),
                              ),
                            ),
                            TextField(
                              onChanged: (value) {
                                newTaskTitle = value;
                              },
                              textAlign: TextAlign.center,
                              autofocus: true,
                              decoration: InputDecoration(),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  // setState(() {
                                  //   print(newTaskTitle);
                                  //   Provider.of<TaskData>(context,
                                  //           listen: false)
                                  //       .addTask(newTaskTitle);
                                  //   Navigator.pushNamed(context, '/');
                                  // });
                                  _firestore
                                      .collection('users')
                                      .doc('$newTaskTitle')
                                      .set({
                                        'userEmail': loggedUser!.email,
                                        'taskName': newTaskTitle,
                                        'taskDate': DateFormat.yMd()
                                            .format(DateTime.now()),
                                        'isDone': taskInit
                                      })
                                      .then((value) => print('Task Add'))
                                      .catchError((error) => (error));
                                  Navigator.pushNamed(context, '/');
                                },
                                child: Text('Add'),
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    minimumSize: MaterialStateProperty.all(
                                        Size(double.maxFinite, 50)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            kMainBlue)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
