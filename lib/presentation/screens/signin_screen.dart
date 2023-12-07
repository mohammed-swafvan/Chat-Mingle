import 'package:chat_mingle/presentation/screens/forgot_screen.dart';
import 'package:chat_mingle/presentation/screens/signup_screen.dart';
import 'package:chat_mingle/presentation/utils/custom_size.dart';
import 'package:chat_mingle/presentation/widgets/auth_button.dart';
import 'package:chat_mingle/presentation/widgets/gradient_container.dart';
import 'package:chat_mingle/presentation/widgets/text_field_box.dart';
import 'package:chat_mingle/provider/signin_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
                        'SignIn',
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Login to your Account',
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
                          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 18),
                          height: screenHeight / 2,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            color: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.grey.shade900,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Consumer<SignInNotifier>(builder: (context, notifier, _) {
                            return Form(
                              key: notifier.formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                                    visibleButtonTap: () {
                                      notifier.changePasswordVisibility();
                                    },
                                    isVibleOff: notifier.passWordVisibility,
                                  ),
                                  CustomSize.height5,
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const ForgotScreen(),
                                        ),
                                      );
                                    },
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text('Forgot Password? ', style: Theme.of(context).textTheme.labelMedium),
                                    ),
                                  ),
                                  CustomSize.height40,
                                  InkWell(
                                    onTap: () async {
                                      if (notifier.formKey.currentState!.validate()) {
                                        await notifier.userLogin(
                                          context: context,
                                          email: notifier.emailController.text,
                                          password: notifier.passwordController.text,
                                        );
                                      }
                                    },
                                    child: const AuthButton(text: "SignIn"),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    Consumer<SignInNotifier>(builder: (context, notifier, _) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an Account? ", style: Theme.of(context).textTheme.labelLarge),
                          InkWell(
                            onTap: () {
                              notifier.disposeControllers();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Sign Up',
                              style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      );
                    }),
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
