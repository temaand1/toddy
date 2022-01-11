import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        icon: icon,
        onPressed: onPressed,
        label: Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
            fixedSize: Size(250, 50),
            primary: Theme.of(context).colorScheme.primary,
            shape: const StadiumBorder(),
            shadowColor: Theme.of(context).colorScheme.primaryVariant),
      ),
    );
  
  }
}
