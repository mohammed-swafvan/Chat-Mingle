import 'package:flutter/material.dart';

class SignInNotifier extends ChangeNotifier {

  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
}
