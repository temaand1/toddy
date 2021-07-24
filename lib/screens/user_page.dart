import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toddyapp/constants.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final _userName = _auth.currentUser!.email.toString();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: kMainPadding,
          child: Column(
            children: [
              CircleAvatar(child: Icon(Icons.person)),
              Text(_userName),
            ],
          ),
        ),
      ),
    );
  }
}
