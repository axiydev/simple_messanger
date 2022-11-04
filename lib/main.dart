import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_messanger/pages/auth/sign_in/sign_in_view.dart';
import 'package:simple_messanger/pages/home/home_page.dart';
import 'package:simple_messanger/services/app_setup.dart';

void main() async {
  await AppSetup.setup;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }

          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return HomePage();
            } else {
              return const SignInView();
            }
          }
          return const SignInView();
        },
      ),
    );
  }
}
