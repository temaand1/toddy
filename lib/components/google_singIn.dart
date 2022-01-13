import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toddyapp/models/google_auth.dart';

class GoogleSingInButton extends StatelessWidget {
  const GoogleSingInButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () async {
        try {
          // ignore: unused_local_variable
          await GoogleAuth().signInwithGoogle();
          Navigator.pushNamed(context, 'TaskScreen');
        } catch (e) {
          print(e);
        }
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: 250,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), color: Theme.of(context).backgroundColor),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FaIcon(
                  FontAwesomeIcons.google,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Text(
                  'Sing In with Google',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          )),
    );
  }
}
