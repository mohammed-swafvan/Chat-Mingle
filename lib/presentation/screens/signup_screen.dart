import 'package:chat_mingle/presentation/screens/signin_screen.dart';
import 'package:chat_mingle/presentation/utils/custom_size.dart';
import 'package:chat_mingle/presentation/widgets/auth_button.dart';
import 'package:chat_mingle/presentation/widgets/gradient_container.dart';
import 'package:chat_mingle/presentation/widgets/text_field_box.dart';
import 'package:flutter/material.dart';

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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(' Name', style: Theme.of(context).textTheme.labelLarge),
                              CustomSize.height5,
                              const TextFieldBox(
                                icon: Icons.person_2_outlined,
                                hintText: "Name",
                              ),
                              CustomSize.height25,
                              Text(' Email', style: Theme.of(context).textTheme.labelLarge),
                              CustomSize.height5,
                              const TextFieldBox(
                                icon: Icons.mail_outlined,
                                hintText: "Email",
                              ),
                              CustomSize.height25,
                              Text(' Password', style: Theme.of(context).textTheme.labelLarge),
                              CustomSize.height5,
                              const TextFieldBox(
                                icon: Icons.password,
                                hintText: "Password",
                              ),
                              CustomSize.height25,
                              Text(' Confirm Password', style: Theme.of(context).textTheme.labelLarge),
                              CustomSize.height5,
                              const TextFieldBox(
                                icon: Icons.password,
                                hintText: "Confirm Password",
                              ),
                              CustomSize.height40,
                              InkWell(
                                onTap: () {},
                                child: const AuthButton(text: "SIGN UP"),
                              ),
                            ],
                          ),
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
