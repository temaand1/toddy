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
    return SafeArea(
        child: Container(
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
    ));
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required FirebaseAuth auth,
  })  : _auth = auth,
        super(key: key);

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FirebaseAuth _auth;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: TextFormField(
                validator: (value) => value!.isEmpty || value.contains('@')
                    ? 'Email cannot be blank'
                    : null,
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: InputDecoration(
                    focusColor: Theme.of(context).colorScheme.primary,
                    border: OutlineInputBorder(),
                    labelText: 'Email'),
              )),
          Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: TextFormField(
                validator: (value) => value!.isEmpty || value.length < 6
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
    );
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
