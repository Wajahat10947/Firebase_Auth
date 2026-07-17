import 'package:bunique_studio/auth-screens/Login_View.dart';
import 'package:bunique_studio/auth-screens/Signup_View.dart';
import 'package:bunique_studio/firebase_options.dart';
import 'package:bunique_studio/screens/Home_View.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    // User? user = FirebaseAuth.instance.currentUser;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginView()
      // user != null
      //     ? HomeView()
      //     : LoginView(),
    );
  }
}




