import 'package:flutter/material.dart';

import '../constants.dart';

class ChangeColorButton extends StatelessWidget {
  const ChangeColorButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.04),
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: 250,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: kMainBlue),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.color_lens, color: Colors.white),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.circle, color: Colors.blueAccent),
                    onPressed: () {},
                  ),
                  IconButton(
                      icon: Icon(Icons.circle, color: Colors.orange),
                      onPressed: () {}),
                  IconButton(
                      icon: Icon(Icons.circle, color: Colors.lightGreen),
                      onPressed: () {})
                ],
              )
            ],
          ),
        ));
  }
}
