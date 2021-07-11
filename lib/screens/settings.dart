import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:provider/provider.dart';
import 'package:toddyapp/constants.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: kMainBlue,
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios_outlined,
                            color: Colors.white),
                      ),
                      Text(
                        'Settings',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      Hero(
                        tag: 'person',
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white),
                          child: Icon(
                            Icons.person_sharp,
                            size: 38,
                            color: kMainBlue,
                          ),
                        ),
                      )
                    ],
                  )),
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: SettingsBody(),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsBody extends StatefulWidget {


  @override
  _SettingsBodyState createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SettingsBodyButton(
          icon: Icons.color_lens_outlined,
          title: 'Color Scheme',
          onTap: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff757575)),
                        color: Color(0xff757575),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)),
                            color: Colors.white),
                        child: Padding(
                          padding: kMainPadding,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Text(
                                  'Choose your color!',
                                  style:
                                      TextStyle(fontSize: 26, color: kMainBlue),
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.only(bottom: 30),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          icon: Icon(
                                            Icons.color_lens,
                                            color: kMainBlue,
                                          ),
                                          onPressed: () {}),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          },
        )
      ],
    );
  }
}

class SettingsBodyButton extends StatelessWidget {
  final title;
  final Function onTap;
  final IconData icon;
  const SettingsBodyButton({

    required this.title,
    required this.onTap,
    required this.icon,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.5),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: ListTile(
          onTap: onTap(),
          leading: Icon(
            icon,
            color: Colors.white,
          ),
          tileColor: kMainBlue,
          title: Text(
            title,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
