import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toddyapp/services/get_icon.dart';

import 'user_modal_page.dart';

class TopBar extends StatelessWidget {
  final FirebaseAuth auth;
  const TopBar({Key? key, required this.auth}) : super(key: key);

  Future<dynamic> userModalPage(BuildContext context) =>
      showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return NewUserPage();
          });

  @override
  Widget build(BuildContext context) {
    String? profileImage = auth.currentUser!.photoURL;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).backgroundColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Hero(
              tag: 'icon',
              child: Container(
                padding: EdgeInsets.all(3),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).backgroundColor),
                child: getIcon(context),
              ),
            ),
            GestureDetector(
              onTap: () {
                auth.currentUser != null
                    ? userModalPage(context)
                    : Navigator.pushNamed(context, 'Login');
              },
              child: Container(
                padding: EdgeInsets.all(3),
                child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Container(
                      width: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(45),
                        child: (profileImage != null)
                            ? Image(
                                image: NetworkImage(
                                    auth.currentUser!.photoURL.toString()),
                              )
                            : Icon(
                                Icons.person,
                                color: Theme.of(context).backgroundColor,
                              ),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
