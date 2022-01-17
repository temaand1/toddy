import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toddyapp/global/theme/app_themes.dart';
import 'package:toddyapp/global/theme/bloc/theme_bloc.dart';
import 'package:toddyapp/services/get_initial_theme.dart';

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
            border: Border.all(
                color: Theme.of(context).colorScheme.primary, width: 2),
            borderRadius: BorderRadius.circular(25),
            color: Theme.of(context).backgroundColor),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.color_lens,
                  color: Theme.of(context).colorScheme.primary),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.circle, color: Colors.blueAccent),
                    onPressed: () {
                      setState(() {
                        HapticFeedback.lightImpact();

                        GetInitialTheme().setTheme(theme: 'AppTheme.Blue');
                        context
                            .read<ThemeBloc>()
                            .add(ThemeChanged(theme: AppTheme.Blue));
                      });
                    },
                  ),
                  IconButton(
                      icon: Icon(Icons.circle, color: Colors.orange),
                      onPressed: () {
                        HapticFeedback.lightImpact();

                        setState(() {
                          GetInitialTheme().setTheme(theme: 'AppTheme.Orange');
                          context
                              .read<ThemeBloc>()
                              .add(ThemeChanged(theme: AppTheme.Ogange));
                        });
                      }),
                  IconButton(
                      icon: Icon(Icons.circle, color: Colors.lightGreen),
                      onPressed: () {
                        HapticFeedback.lightImpact();

                        setState(() {
                          GetInitialTheme().setTheme(theme: 'AppTheme.Green');
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
