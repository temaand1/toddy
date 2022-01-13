// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Theme.of(context).backgroundColor),
          title: Text(
            'Welcome',
            style: TextStyle(color: Theme.of(context).backgroundColor),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          actions: [
            Hero(tag: 'icon', child: getIcon(context, size: 100.0)),
          ],
        ),
        body: Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 236,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
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
                                  focusColor:
                                      Theme.of(context).colorScheme.primary,
                                  border: OutlineInputBorder(),
                                  labelText: 'Email'),
                            )),
                        Padding(
                            padding: EdgeInsets.only(bottom: 16),
                            child: TextFormField(
                              validator: (value) =>
                                  value!.isEmpty || value.length < 6
                                      ? 'Minimum 6 symbols'
                                      : null,
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: 'Minimum 6 symbols',
                                  border: OutlineInputBorder(),
                                  labelText: 'Password'),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RegisterButton(
                                auth: _auth,
                                emailController: emailController,
                                passwordController: passwordController),
                            SingInButton(
                                auth: _auth,
                                emailController: emailController,
                                passwordController: passwordController),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )));
  }
}

class SingInButton extends StatelessWidget {
  const SingInButton({
    Key? key,
    required FirebaseAuth auth,
    required this.emailController,
    required this.passwordController,
  })  : _auth = auth,
        super(key: key);

  final FirebaseAuth _auth;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        try {
          // ignore: unused_local_variable
          final user = await _auth.signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

          Navigator.pushNamed(context, '/');
        } on FirebaseException catch (e) {
          if (e.code == 'user-not-found') {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    title: Text("Error"),
                    content: Text('User not found'),
                    actions: [
                      TextButton(
                        child: Text("Ok"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                });
          } else if (e.code == 'wrong-password') {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    title: Text("Error"),
                    content: Text('Wrong password'),
                    actions: [
                      TextButton(
                        child: Text("Ok"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                });
          }
        }
      },
      child: Container(
          width: 80,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).colorScheme.primary),
          child: Center(
            child: Text(
              'LOGIN',
              style: TextStyle(color: Theme.of(context).backgroundColor),
            ),
          )),
    );
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    Key? key,
    required FirebaseAuth auth,
    required this.emailController,
    required this.passwordController,
  })  : _auth = auth,
        super(key: key);

  final FirebaseAuth _auth;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        try {
          // ignore: unused_local_variable
          final user = await _auth.createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

          Navigator.pushNamed(context, '/');
        } on FirebaseException catch (e) {
          if (e.code == 'invalid-email') {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    title: Text("Error"),
                    content: Text('Please enter correct email adress'),
                    actions: [
                      TextButton(
                        child: Text("Ok"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                });
          } else if (e.code == 'weak-password') {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    title: Text("Error"),
                    content: Text('The password is too weak'),
                    actions: [
                      TextButton(
                        child: Text("Ok"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                });
          } else if (e.code == 'email-already-in-use') {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    title: Text("Error"),
                    content: Text('Email already in use'),
                    actions: [
                      TextButton(
                        child: Text("Ok"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                });
          }
        }
      },
      child: Container(
          width: 80,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).colorScheme.primary),
          child: Center(
            child: Text(
              'REGISTER',
              style: TextStyle(color: Theme.of(context).backgroundColor),
            ),
          )),
    );
  }
}
