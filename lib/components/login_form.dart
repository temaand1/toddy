import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'registration_button.dart';
import 'sing_in_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required FirebaseAuth auth,
  })  : _auth = auth,
        super(key: key);

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FirebaseAuth _auth;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                validator: (value) => value!.isEmpty || value.contains('@')
                    ? 'Email cannot be blank'
                    : null,
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: InputDecoration(
                    focusColor: Theme.of(context).colorScheme.primary,
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'Email'),
              )),
          Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                validator: (value) => value!.isEmpty || value.length < 6
                    ? 'Minimum 6 symbols'
                    : null,
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    fillColor: Theme.of(context).backgroundColor,
                    hintText: 'Minimum 6 symbols',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'Password'),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RegisterButton(
                  auth: _auth,
                  emailController: emailController,
                  passwordController: passwordController),
              SingInButton(
                  auth: _auth,
                  emailController: emailController,
                  passwordController: passwordController),
            ],
          ),
        ],
      ),
    );
  }
}
