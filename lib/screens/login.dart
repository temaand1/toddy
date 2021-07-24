import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toddyapp/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toddyapp/screens/tasks_screen.dart';

class WelcomeScreen extends StatelessWidget {
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    if (currentUser != null) {
      return TasksScreen();
    }
    return Login();
  }
}

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
    return Scaffold(
        backgroundColor: kMainBlue,
        appBar: AppBar(
          title: Text('Welcome'),
          backgroundColor: kAccentColor,
          actions: [
            Hero(
              tag: 'icon',
              child: Image.asset(
                'assets/icon.png',
                width: 100,
                height: 100,
              ),
            ),
          ],
        ),
        body: Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Container(
                height: 236,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: TextFormField(
                          validator: (value) =>
                              value!.isEmpty || value.contains('@')
                                  ? 'Email cannot be blank'
                                  : null,
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
                          obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password'),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () async {
                            try {
                              // ignore: unused_local_variable
                              final user =
                                  await _auth.createUserWithEmailAndPassword(
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
                                  'REGISTER',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        ),
                        TextButton(
                          onPressed: () async {
                            try {
                              // ignore: unused_local_variable
                              final user =
                                  await _auth.signInWithEmailAndPassword(
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
                                  'LOGIN',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )));
  }
}
