import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:toddyapp/components/add_button.dart';
import 'package:toddyapp/components/task_tile.dart';
import 'package:toddyapp/components/user_modal_page.dart';
import 'package:toddyapp/components/week_view.dart';
import 'package:toddyapp/constants.dart';
import 'package:toddyapp/models/task_data.dart';
import 'package:toddyapp/services/get_icon.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  String userEmail = FirebaseAuth.instance.currentUser!.email.toString();
  final _auth = FirebaseAuth.instance;
  String? profileImage = FirebaseAuth.instance.currentUser!.photoURL;

  final quickAction = QuickActions();

  @override
  void initState() {
    super.initState();

    quickAction.setShortcutItems([
      ShortcutItem(type: 'add', localizedTitle: 'Add task', icon: 'add'),
      ShortcutItem(
          type: 'expired', localizedTitle: 'Expire tasks', icon: 'Expired'),
    ]);

    quickAction.initialize((type) {
      if (type == 'add') {
        AddButton().createState().addTaskDialog(context, '',
            DateFormat.yMd().format(DateTime.now()), DateTime.now());
      } else if (type == 'expired') {
        Navigator.pushNamed(context, 'ExpireTasks');
      }
    });
  }

  logOut() async {
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskData>(
        create: (BuildContext context) => TaskData(),
        child: Scaffold(
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
                        Hero(
                          tag: 'icon',
                          child: Container(
                            padding: EdgeInsets.all(3),
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white),
                            child: getIcon(context),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _auth.currentUser != null
                                ? userModalPage(context)
                                : Navigator.pushNamed(context, 'Login');
                          },
                          child: Container(
                            padding: EdgeInsets.all(3),
                            child: CircleAvatar(
                                radius: 20,
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                child: Container(
                                  width: 35,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(45),
                                    child: (profileImage != null)
                                        ? Image(
                                            image: NetworkImage(_auth
                                                .currentUser!.photoURL
                                                .toString()),
                                          )
                                        : Icon(
                                            Icons.person,
                                            color: Colors.white,
                                          ),
                                  ),
                                )),
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
        ));
  }

  Future<dynamic> userModalPage(BuildContext context) =>
      showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return NewUserPage();
          });
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
              return Center(
                  child: CircularProgressIndicator.adaptive(
                backgroundColor: Theme.of(context).colorScheme.primary,
              ));
          }),
    );
  }
}
