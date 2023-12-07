import 'package:chat_mingle/presentation/screens/home_screen.dart';
import 'package:chat_mingle/presentation/utils/utils.dart';
import 'package:chat_mingle/services/auth_services.dart';
import 'package:flutter/material.dart';

class SignInNotifier extends ChangeNotifier {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future userLogin({required BuildContext context, required String email, required String password}) async {
    String emailValidation = email.substring(email.length - 10);
    if (emailValidation != "@gmail.com" || email.length < 13) {
      notifyListeners();
      if (context.mounted) {
        return Utils().customSnackBar(context: context, content: 'Email is not a valid email');
      }
    }

    isLoading = true;
    notifyListeners();
    String result = await AuthServices().userLogin(context: context, email: email, password: password);
    isLoading = false;
    disposeControllers();
    notifyListeners();
    if (result == 'success') {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    }
  }

  disposeControllers() {
    emailController.clear();
    passwordController.clear();
  }
}
