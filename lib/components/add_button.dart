import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_field/date_field.dart';
import '../constants.dart';

class AddButton extends StatefulWidget {
  @override
  _AddButtonState createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  final _firestore = FirebaseFirestore.instance;

  final bool taskInit = false;
  String loggedUser = FirebaseAuth.instance.currentUser!.email.toString();

  @override
  void initState() {
    super.initState();
    print(loggedUser);
  }

  @override
  Widget build(BuildContext context) {
    String newTaskTitle = "";
    String taskDay = DateFormat.yMd().format(DateTime.now());

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
                      color: Colors.grey.shade900,
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
                              decoration:
                                  InputDecoration(border: OutlineInputBorder()),
                            ),
                            SizedBox(height: 20),
                            Container(
                              height: 100,
                              child: DateTimeField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.event_note),
                                ),
                                mode: DateTimeFieldPickerMode.date,
                                onDateSelected: (DateTime value) {
                                  taskDay = DateFormat.yMd().format(value);
                                  print(taskDay);
                                },
                                selectedDate: DateTime.now(),
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  _firestore
                                      .collection('$loggedUser')
                                      .doc('$newTaskTitle')
                                      .set({
                                        'userEmail': loggedUser,
                                        'taskName': newTaskTitle,
                                        'taskDate': taskDay,
                                        'isDone': taskInit
                                      })
                                      .then((value) =>
                                          print('Task Add on $taskDay'))
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
