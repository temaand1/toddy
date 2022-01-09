import 'package:flutter/material.dart';

import '../constants.dart';

class BigButton extends StatelessWidget {
  final onPressed;
  final String name;
  final Widget icon;
  const BigButton({
    Key? key,
    required this.onPressed,
    required this.name,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: 250,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), color: kMainBlue),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                icon,
                Text(
                  name,
                  style: TextStyle(color: kAccentColor),
                ),
              ],
            ),
          )),
    );
  }
}
