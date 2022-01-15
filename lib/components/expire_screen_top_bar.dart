import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ExpireTopBar extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  ExpireTopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? profileImage = _auth.currentUser!.photoURL;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _auth.currentUser != null
                    ? Navigator.pushNamed(context, 'User')
                    : Navigator.pushNamed(context, 'Login');
              },
              child: Container(
                padding: EdgeInsets.all(3),
                child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Container(
                      width: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(45),
                        child: (profileImage != null)
                            ? Image(
                                image: NetworkImage(
                                    _auth.currentUser!.photoURL.toString()),
                              )
                            : Icon(
                                Icons.person,
                                color: Theme.of(context).colorScheme.primary,
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
