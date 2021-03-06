import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toddyapp/global/blocs/task_day_bloc/bloc/selected_day_bloc.dart';

import '../constants.dart';
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
  }

  _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        showSearchBar: false,
        title: SizedBox(),
        iconPickerShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0))
        constraints:
            BoxConstraints(maxHeight: 180, minWidth: 450, maxWidth: 720),

        iconPackModes: [IconPack.custom],
        customIconPack: myIconPack,
        closeChild: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 40,
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), color: Theme.of(context).colorScheme.primary,)
          child: Center(
            child: Text(
              'Close',
              style: TextStyle(color: Theme.of(context).backgroundColor

              ),
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
    
    
    

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          addTaskDialog(context);
          HapticFeedback.mediumImpact();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> addTaskDialog(BuildContext context, 
       ) {
         String newTaskTitle = "New Task :)";
         String? addTaskDay;
        //  String taskDay = DateFormat.yMd().format(context.read<SelectedDayBloc>().state);
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
                    color: Theme.of(context).backgroundColor),
                child: Padding(
                  padding: kMainPadding * 0.7,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          'Add Task',
                          style: TextStyle(fontSize: 26, color: Theme.of(context).scaffoldBackgroundColor),
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
                            fillColor: Theme.of(context).scaffoldBackgroundColor,
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.event_note),
                          ),
                          mode: DateTimeFieldPickerMode.date,
                          onDateSelected: (DateTime value) {
                            setState(() {
                              addTaskDay = DateFormat.yMd().format(value);
                              context.read<SelectedDayBloc>().add(SelectedDayChanded(day: value));
                            });
                            
                          },
                          selectedDate: context.watch<SelectedDayBloc>().state,
                          ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ChooseIconButton(
                              onPressed: () {
                                HapticFeedback.lightImpact();
                                return _pickIcon();
                              },
                            ),
                            AddTaskButton(
                              onPressed: () {
                                HapticFeedback.lightImpact();

                                setState(() {
                                  _firestore
                                      .collection('$loggedUser')
                                      .doc('$newTaskTitle')
                                      .set({
                                        'userEmail': loggedUser,
                                        'taskName': newTaskTitle,
                                        'taskDate': addTaskDay ?? DateFormat.yMd().format(context.read<SelectedDayBloc>().state),
                                        'isDone': taskInit,
                                        'icon': selectedIcon
                                      })
                                      
                                      .catchError((error) => (error));
                                });
                                Navigator.pop(context);
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
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), color: Theme.of(context).colorScheme.primary),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FaIcon(
                FontAwesomeIcons.icons,
                color: Theme.of(context).backgroundColor,
              ),
              Text(
                ' Choose Icon',
                style: TextStyle(color: Theme.of(context).backgroundColor),
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
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), color: Theme.of(context).colorScheme.primary),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Add Task',
                style: TextStyle(color: Theme.of(context).backgroundColor),
              ),
              FaIcon(
                FontAwesomeIcons.plusCircle,
                color: Theme.of(context).backgroundColor,
              ),
            ],
          ),
        ));
  }
}
