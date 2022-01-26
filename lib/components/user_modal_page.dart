import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toddyapp/components/change_color_button.dart';
import 'package:toddyapp/services/google_auth.dart';

import 'big_button.dart';

class NewUserPage extends StatefulWidget {
  const NewUserPage({Key? key}) : super(key: key);

  @override
  State<NewUserPage> createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  @override
  Widget build(BuildContext context) {
    final _firestore = FirebaseFirestore.instance;
    final _auth = FirebaseAuth.instance;
    final _userName = _auth.currentUser!.email.toString();
    final _userAvatar = _auth.currentUser?.photoURL;
    return Material(
      type: MaterialType.transparency,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Theme.of(context).backgroundColor,
        ),
        margin: EdgeInsets.all(15),
        width: 400,
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.72,
            minWidth: 400),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: Column(
                children: [
                  Hero(
                    tag: 'person',
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Container(
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(45),
                          child: (_userAvatar != null)
                              ? Image(
                                  image: NetworkImage(
                                      _auth.currentUser!.photoURL.toString()),
                                )
                              : Icon(
                                  Icons.person,
                                  color: Theme.of(context).backgroundColor,
                                ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    width: 250,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Theme.of(context).colorScheme.primary),
                    child: Center(
                      child: Text(
                        _userName,
                        // TODO: Test email overflow
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            color: Theme.of(context).backgroundColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  ChangeColorButton(),
                  BigButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, 'ExpireTasks'),
                      name: 'Expire tasks',
                      icon: FaIcon(
                        FontAwesomeIcons.tasks,
                        color: Theme.of(context).backgroundColor,
                      )),
                  BigButton(
                      onPressed: () async {
                        await GoogleAuth().signOutFromGoogle();
                        Navigator.pushNamed(context, '/');
                      },
                      name: 'Sing Out',
                      icon: FaIcon(
                        FontAwesomeIcons.signOutAlt,
                        color: Theme.of(context).backgroundColor,
                      )),
                  BigButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                title: Text("Hey !"),
                                content: Text('Delete all your Todos ?'),
                                actions: [
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text('No')),
                                  TextButton(
                                    child: Text(
                                      "Ok",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                    onPressed: () {
                                      _firestore
                                          .collection('$_userName')
                                          .get()
                                          .then((snapshot) {
                                        for (DocumentSnapshot ds
                                            in snapshot.docs) {
                                          ds.reference.delete();
                                        }
                                      });
                                      Navigator.pushNamed(context, '/');
                                    },
                                  )
                                ],
                              );
                            });
                      },
                      name: 'Delete all',
                      icon: FaIcon(
                        FontAwesomeIcons.eraser,
                        color: Theme.of(context).backgroundColor,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
