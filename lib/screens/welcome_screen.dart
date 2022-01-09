import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toddyapp/components/google_singIn.dart';
import 'package:toddyapp/screens/tasks_screen.dart';

class WelcomeScreen extends StatelessWidget {
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    if (currentUser != null) {
      return TasksScreen();
    }
    return SafeArea(
        child: Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 'icon',
            child: Container(
              margin: EdgeInsets.only(bottom: 50),
              padding: EdgeInsets.all(10),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: Colors.white),
              child: Image.asset(
                'assets/icon.png',
                width: 30,
                height: 30,
              ),
            ),
          ),
          SingInButton(),
          SizedBox(
            height: 10,
          ),
          GoogleSingInButton()
        ],
      ),
    ));
  }
}

class SingInButton extends StatelessWidget {
  const SingInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, 'Login'),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: 250,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), color: Colors.white),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FaIcon(
                  FontAwesomeIcons.signInAlt,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Text(
                  'Sing In or Sing Up',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          )),
    );
  }
}
