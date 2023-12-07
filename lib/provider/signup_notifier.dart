import 'package:chat_mingle/presentation/screens/home_screen.dart';
import 'package:chat_mingle/presentation/utils/utils.dart';
import 'package:chat_mingle/services/auth_services.dart';
import 'package:flutter/material.dart';

class SignUpNotifier extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool passwordVisibility = true;
  bool confirmPasswordVisibility = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  passWordVisibilityChange() {
    passwordVisibility = !passwordVisibility;
    notifyListeners();
  }

  confirmPassWordVisibilityChange() {
    confirmPasswordVisibility = !confirmPasswordVisibility;
    notifyListeners();
  }

  disposeController() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  Future registration({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (email.length < 10) {
      emailController.clear();
      notifyListeners();
      if (context.mounted) {
        return Utils().customSnackBar(context: context, content: 'Email is not a valid email');
      }
    }

    String emailValidation = email.substring(email.length - 10);
    if (emailValidation != "@gmail.com" || emailValidation.length < 13) {
      disposeController();
      notifyListeners();
      if (context.mounted) {
        return Utils().customSnackBar(context: context, content: 'Email is not a valid email');
      }
    }
    isLoading = true;
    notifyListeners();
    String res = await AuthServices().register(
      context: context,
      name: name,
      email: email,
      password: password,
    );
    isLoading = false;
    disposeController();
    notifyListeners();

    if (res == 'success') {
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
}
