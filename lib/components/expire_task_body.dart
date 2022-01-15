
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toddyapp/components/task_tile.dart';

class ExpireTaskbody extends StatefulWidget {
  @override
  _ExpireTaskbodyState createState() => _ExpireTaskbodyState();
}

class _ExpireTaskbodyState extends State<ExpireTaskbody> {
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
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
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
                            DaysAgo().yesterday ||
                        streamSnapshot.data!.docs[index]['taskDate'] ==
                            DaysAgo().twoDaysAgo ||
                        streamSnapshot.data!.docs[index]['taskDate'] ==
                            DaysAgo().threeDaysAgo ||
                        streamSnapshot.data!.docs[index]['taskDate'] ==
                            DaysAgo().fourDaysAgo ||
                        streamSnapshot.data!.docs[index]['taskDate'] ==
                            DaysAgo().fiveDaysAgo ||
                        streamSnapshot.data!.docs[index]['taskDate'] ==
                            DaysAgo().sixDaysAgo ||
                        streamSnapshot.data!.docs[index]['taskDate'] ==
                            DaysAgo().sevenDaysAgo) {
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
      ),
    );
  }
}

class DaysAgo {
  String yesterday =
      DateFormat.yMd().format(DateTime.now().subtract(Duration(days: 1)));
  String twoDaysAgo =
      DateFormat.yMd().format(DateTime.now().subtract(Duration(days: 2)));
  String threeDaysAgo =
      DateFormat.yMd().format(DateTime.now().subtract(Duration(days: 4)));
  String fourDaysAgo =
      DateFormat.yMd().format(DateTime.now().subtract(Duration(days: 5)));
  String fiveDaysAgo =
      DateFormat.yMd().format(DateTime.now().subtract(Duration(days: 6)));
  String sixDaysAgo =
      DateFormat.yMd().format(DateTime.now().subtract(Duration(days: 7)));
  String sevenDaysAgo =
      DateFormat.yMd().format(DateTime.now().subtract(Duration(days: 8)));
}
