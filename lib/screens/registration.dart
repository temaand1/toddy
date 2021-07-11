import 'package:flutter/material.dart';
import 'package:toddyapp/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Registration extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegistrationState();
  }
}

class RegistrationState extends State<Registration> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kMainBlue,
        appBar: AppBar(
          title: Text('Sing Up'),
          backgroundColor: kAccentColor,
        ),
        body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                          focusColor: kAccentColor,
                          border: OutlineInputBorder(),
                          labelText: 'Email'),
                    )),
                Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: TextField(
                      controller: passwordController,
                      style: TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Password'),
                    )),
                TextButton(
                  onPressed: () async {
                    try {
                      final user = await _auth.createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text);

                      Navigator.pushNamed(context, '/');
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: kAccentColor),
                      child: Center(
                        child: Text(
                          'Registration',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
            )));
  }
}
