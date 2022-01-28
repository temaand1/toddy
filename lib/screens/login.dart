// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toddyapp/components/login_form.dart';
import 'package:toddyapp/components/registration_button.dart';
import 'package:toddyapp/components/sing_in_button.dart';
import 'package:toddyapp/constants.dart';
import 'package:toddyapp/services/get_icon.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: Stack(
    alignment: AlignmentDirectional.topCenter,
    children: [
      Container(
        decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(
                width: 0,
                color: Theme.of(context)
                    .colorScheme
                    .primary
                    .withOpacity(0.7))),
        height: MediaQuery.of(context).size.height * 0.3,
      ),
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.7),
              Theme.of(context).colorScheme.primary,
            ], begin: Alignment.topRight, end: Alignment.bottomLeft),
            border: Border.all(
              width: 0,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
            ),
            borderRadius:
                BorderRadius.only(bottomRight: Radius.circular(75))),
        height: MediaQuery.of(context).size.height * 0.3,
      ),
      Container(
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.2,
              left: MediaQuery.of(context).size.width * 0.7),
          child: getIcon(context, size: 60.0)),
      Container(
        child: Material(
          color: Colors.black,
          child: LoginForm(
              emailController: emailController,
              passwordController: passwordController,
              auth: _auth),
        ),
        margin:
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
        decoration: BoxDecoration(
            border: Border.all(
              width: 0,
            ),
            color: Colors.black,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(75))),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.7,
      )
    ],
      ),
    );
  }
}






