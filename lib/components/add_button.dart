import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:date_field/date_field.dart';
import 'package:provider/provider.dart';
import 'package:toddyapp/models/task_data.dart';
import '../constants.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

import 'custom_iconpack.dart';

class AddButton extends StatefulWidget {
  @override
  _AddButtonState createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  final _firestore = FirebaseFirestore.instance;

  final bool taskInit = false;
  String loggedUser = FirebaseAuth.instance.currentUser!.email.toString();
  int selectedIcon = Icons.circle.codePoint;

  @override
  void initState() {
    super.initState();
    print(loggedUser);
  }

  _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        showSearchBar: false,
        title: SizedBox(),
        iconPickerShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0))
        constraints:
            BoxConstraints(maxHeight: 180, minWidth: 450, maxWidth: 720),

        iconPackMode: IconPack.custom,
        customIconPack: myIconPack,
        closeChild: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 40,
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), color: kAccentColor),
          child: Center(
            child: Text(
              'Close',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ));

    if (icon != null) {
      selectedIcon = icon.codePoint;
    }

    setState(() {});

    debugPrint('Picked Icon:  $icon');
  }

  @override
  Widget build(BuildContext context) {
    String newTaskTitle = "";
    String taskDay = DateFormat.yMd().format(DateTime.now());
    DateTime selectedDate = DateTime.now();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton(
        backgroundColor: kAccentColor,
        onPressed: () {
          addTaskDialog(context, newTaskTitle, taskDay, selectedDate);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> addTaskDialog(BuildContext context, String newTaskTitle,
      String taskDay, DateTime selectedDate) {
    return showModalBottomSheet(
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
                          style: TextStyle(fontSize: 26, color: kMainBlue),
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
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        child: DateTimeField(
                          decoration: InputDecoration(
                            fillColor: kMainBlue,
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.event_note),
                          ),
                          mode: DateTimeFieldPickerMode.date,
                          onDateSelected: (DateTime value) {
                            taskDay = DateFormat.yMd().format(value);
                            selectedDate = value;
                          },
                          selectedDate: selectedDate,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ChooseIconButton(
                              onPressed: () => _pickIcon(),
                            ),
                            AddTaskButton(
                              onPressed: () {
                                setState(() {
                                  _firestore
                                      .collection('$loggedUser')
                                      .doc('$newTaskTitle')
                                      .set({
                                        'userEmail': loggedUser,
                                        'taskName': newTaskTitle,
                                        'taskDate': taskDay,
                                        'isDone': taskInit,
                                        'icon': selectedIcon
                                      })
                                      .then((value) =>
                                          print('Task Add on $taskDay'))
                                      .catchError((error) => (error));
                                });
                                Navigator.pushNamed(context, '/');
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class ChooseIconButton extends StatelessWidget {
  final onPressed;
  const ChooseIconButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 50,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), color: kAccentColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FaIcon(
                FontAwesomeIcons.icons,
                color: Colors.white,
              ),
              Text(
                ' Choose Icon',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ));
  }
}

class AddTaskButton extends StatelessWidget {
  final onPressed;
  const AddTaskButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 50,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), color: kAccentColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Add Task',
                style: TextStyle(color: Colors.white),
              ),
              FaIcon(
                FontAwesomeIcons.plusCircle,
                color: Colors.white,
              ),
            ],
          ),
        ));
  }
}
