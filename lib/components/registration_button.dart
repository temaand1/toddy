import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        HapticFeedback.lightImpact();

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
