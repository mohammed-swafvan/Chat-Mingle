import 'package:chat_mingle/presentation/screens/signin_screen.dart';
import 'package:chat_mingle/provider/forgot_password_notifier.dart';
import 'package:chat_mingle/provider/signin_notifier.dart';
import 'package:chat_mingle/provider/signup_notifier.dart';
import 'package:chat_mingle/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  await Firebase.initializeApp().then(
    (value) => runApp(
      const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignUpNotifier()),
        ChangeNotifierProvider(create: (_) => SignInNotifier()),
        ChangeNotifierProvider(create: (_) => ForgotPasswordNotifier()),
      ],
      child: MaterialApp(
        title: 'Chat Mingle',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: const SignInScreen(),
      ),
    );
  }
}
