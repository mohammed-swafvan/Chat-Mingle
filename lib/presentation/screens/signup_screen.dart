import 'package:chat_mingle/presentation/screens/signin_screen.dart';
import 'package:chat_mingle/presentation/utils/custom_size.dart';
import 'package:chat_mingle/presentation/widgets/auth_button.dart';
import 'package:chat_mingle/presentation/widgets/gradient_container.dart';
import 'package:chat_mingle/presentation/widgets/text_field_box.dart';
import 'package:chat_mingle/provider/signup_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight,
          child: Stack(
            children: [
              const GradientContainer(),
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'SignUp',
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Create a new Account',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    CustomSize.height15,
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: Material(
                        elevation: 6.0,
                        shadowColor: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.grey.shade500,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
                          height: screenHeight / 1.5,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.grey.shade900,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Consumer<SignUpNotifier>(builder: (context, notifier, _) {
                            return Form(
                              key: notifier.formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(' Name', style: Theme.of(context).textTheme.labelLarge),
                                  CustomSize.height5,
                                  TextFieldBox(
                                    controller: notifier.nameController,
                                    icon: Icons.person_2_outlined,
                                    hintText: "Name",
                                  ),
                                  CustomSize.height25,
                                  Text(' Email', style: Theme.of(context).textTheme.labelLarge),
                                  CustomSize.height5,
                                  TextFieldBox(
                                    controller: notifier.emailController,
                                    icon: Icons.mail_outlined,
                                    hintText: "Email",
                                  ),
                                  CustomSize.height25,
                                  Text(' Password', style: Theme.of(context).textTheme.labelLarge),
                                  CustomSize.height5,
                                  TextFieldBox(
                                    controller: notifier.passwordController,
                                    icon: Icons.password,
                                    hintText: "Password",
                                  ),
                                  CustomSize.height25,
                                  Text(' Confirm Password', style: Theme.of(context).textTheme.labelLarge),
                                  CustomSize.height5,
                                  TextFieldBox(
                                    controller: notifier.confirmPasswordController,
                                    icon: Icons.password,
                                    hintText: "Confirm Password",
                                  ),
                                  CustomSize.height40,
                                  InkWell(
                                    onTap: () async {
                                      if (notifier.formKey.currentState!.validate()) {
                                        await notifier.registration(
                                          context: context,
                                          name: notifier.nameController.text,
                                          email: notifier.emailController.text,
                                          password: notifier.passwordController.text,
                                          confirmPassword: notifier.confirmPasswordController.text,
                                        );
                                      }
                                    },
                                    child: const AuthButton(text: "SIGN UP"),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an Account? ", style: Theme.of(context).textTheme.labelLarge),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignInScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'SignIn',
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
