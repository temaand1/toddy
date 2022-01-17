import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toddyapp/components/google_singIn.dart';
import 'package:toddyapp/screens/tasks_screen.dart';
import 'package:toddyapp/services/get_icon.dart';

class WelcomeScreen extends StatelessWidget {
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    if (currentUser != null) {
      return TasksScreen();
    }
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
            child: SingInAndSingUpButtons(),
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

class SingInAndSingUpButtons extends StatelessWidget {
  const SingInAndSingUpButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SingInAndSingUpButton(),
        SizedBox(
          height: 20,
        ),
        GoogleSingInButton()
      ],
    );
  }
}

class SingInAndSingUpButton extends StatelessWidget {
  const SingInAndSingUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        HapticFeedback.lightImpact();
        Navigator.pushNamed(context, 'Login');
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: 250,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Theme.of(context).backgroundColor),
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
