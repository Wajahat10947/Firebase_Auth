import 'package:bunique_studio/auth-screens/Login_View.dart';
import 'package:bunique_studio/screens/Home_View.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmpassController = TextEditingController();

  CollectionReference Users = FirebaseFirestore.instance.collection('Users');

  Future<void> SignUp(BuildContext context) async {
    try {
      // Create Firebase Auth User
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passController.text.trim(),
          );

      // Get User UID
      final uid = credential.user!.uid;

      // Add User Data to Firestore
      await FirebaseFirestore.instance.collection('Users').doc(uid).set({
        'uid': uid,
        'Name': nameController.text.trim(),
        'Email': emailController.text.trim(),
        'Phone': phoneController.text.trim(),
        'createdAt': Timestamp.now(),
      });

      print("User Added");

      // Navigate to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeView()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Your Username',
              ),
              controller: nameController,
            ),

            SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Your Email',
              ),
              controller: emailController,
            ),

            SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Your Phone Number',
              ),
              controller: phoneController,
            ),

            SizedBox(height: 20),

            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Your Password',
              ),
              controller: passController,
            ),

            SizedBox(height: 20),

            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Confirm Password',
              ),
              controller: confirmpassController,
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                await SignUp(context);
              },
              child: Text("Register Now"),
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already Have an Account?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => LoginView(),
                      ),
                    );
                  },
                  child: Text(
                    "Login Here",
                    style: TextStyle(
                      fontWeight: FontWeight(700),
                      color: Colors.amber,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
