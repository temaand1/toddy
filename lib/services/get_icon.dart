import 'package:flutter/material.dart';

Image getIcon(BuildContext context, {size}) {
  if (Theme.of(context).colorScheme.primary == Colors.lightBlue) {
    return Image.asset(
      'assets/icon_blue.png',
      width: size ?? 30,
      height: size ?? 30,
    );
  } else if (Theme.of(context).colorScheme.primary == Colors.lightGreen) {
    return Image.asset(
      'assets/icon_green.png',
      width: size ?? 30,
      height: size ?? 30,
    );
  } else {
    return Image.asset(
      'assets/icon.png',
      width: size ?? 30,
      height: size ?? 30,
    );
  }
}
