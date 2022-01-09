import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toddyapp/global/theme/app_themes.dart';
import 'package:toddyapp/global/theme/bloc/theme_bloc.dart';

import '../constants.dart';

class ChangeColorButton extends StatefulWidget {
  const ChangeColorButton({
    Key? key,
  }) : super(key: key);

  @override
  State<ChangeColorButton> createState() => _ChangeColorButtonState();
}

class _ChangeColorButtonState extends State<ChangeColorButton> {
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
                    onPressed: () {
                      setState(() {
                        context
                            .read<ThemeBloc>()
                            .add(ThemeChanged(theme: AppTheme.Blue));
                      });
                    },
                  ),
                  IconButton(
                      icon: Icon(Icons.circle, color: Colors.orange),
                      onPressed: () {
                        setState(() {
                          context
                              .read<ThemeBloc>()
                              .add(ThemeChanged(theme: AppTheme.Ogange));
                        });
                      }),
                  IconButton(
                      icon: Icon(Icons.circle, color: Colors.lightGreen),
                      onPressed: () {
                        setState(() {
                          context
                              .read<ThemeBloc>()
                              .add(ThemeChanged(theme: AppTheme.Green));
                        });
                      })
                ],
              )
            ],
          ),
        ));
  }
}
