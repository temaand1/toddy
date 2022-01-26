import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toddyapp/services/firebase_auth.dart';

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
        await HapticFeedback.lightImpact();

        AuthenticationService(_auth).singUp(
            email: emailController.text,
            password: passwordController.text,
            context: context);
        Navigator.of(context).pushNamed('/');
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
