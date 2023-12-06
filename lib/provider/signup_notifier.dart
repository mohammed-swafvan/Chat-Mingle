import 'package:chat_mingle/presentation/screens/home_screen.dart';
import 'package:chat_mingle/services/auth_services.dart';
import 'package:flutter/material.dart';

class SignUpNotifier extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  disposeController() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  registration({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
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
