import 'package:chat_mingle/presentation/screens/home_screen.dart';
import 'package:chat_mingle/presentation/screens/signin_screen.dart';
import 'package:chat_mingle/provider/home_notifier.dart';
import 'package:chat_mingle/provider/shared_pref_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  @override
  void initState() {
    Provider.of<SharedPrefNotifier>(context, listen: false).getSharedPref();
    Provider.of<HomeNotifier>(context, listen: false).getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            Provider.of<SharedPrefNotifier>(context, listen: false).getSharedPref();
            Provider.of<HomeNotifier>(context, listen: false).getAllUsers();
            return const HomeScreen();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Some Error Occured",
                style: TextStyle(color: Colors.red),
              ),
            );
          }
        }

        return const SignInScreen();
      },
    );
  }
}
