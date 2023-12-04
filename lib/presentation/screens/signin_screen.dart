import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'SignInScreen',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
    );
  }
}
