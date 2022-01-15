
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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