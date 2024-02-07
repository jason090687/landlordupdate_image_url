import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tanle/bottom_navbar.dart';
import 'package:tanle/pages/auth_services.dart';

class SignUpPage extends StatefulWidget {
  final Function()? onTap;
  const SignUpPage({super.key, required this.onTap});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final comfirmpasswordcontroller = TextEditingController();

  void signUp() async {
    // Show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
          ),
        );
      },
    );

    try {
      if (passwordcontroller.text == comfirmpasswordcontroller.text) {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text,
          password: passwordcontroller.text,
        );
        FirebaseFirestore.instance
            .collection("Users")
            .doc(userCredential.user!.email)
            .set({
          'username': emailcontroller.text.split('@')[0],
          'bio': 'Empty bio...'
        });
      } else {
        // show error message
        showErrorMessage('Password don\t match!');
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NavBarPages()),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.of(context, rootNavigator: true).pop();

      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            title: Center(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Create',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'We missed you! Login to continue your journey with us.',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: emailcontroller,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(0, 126, 242, 100), width: 2.0),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  style: const TextStyle(fontSize: 14, fontFamily: 'OpenSans'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordcontroller,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.key),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(0, 126, 242, 100), width: 2.0),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  style: const TextStyle(fontSize: 14, fontFamily: 'OpenSans'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: comfirmpasswordcontroller,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: const Icon(Icons.key),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(0, 126, 242, 100), width: 2.0),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  style: const TextStyle(fontSize: 14, fontFamily: 'OpenSans'),
                ),
                const SizedBox(height: 28),
                ElevatedButton(
                  onPressed: () {
                    signUp();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(70, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(thickness: 0.5, color: Colors.black),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or signup with',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'OpenSans',
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(thickness: 0.5, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        border: Border.all(
                          color: const Color.fromRGBO(
                              217, 217, 217, 8), // Change the border color
                          width: 2.0, // Change the border width
                        ),
                      ),
                      child: IconButton(
                        icon: Image.asset(
                          'assets/images/search.png',
                          fit: BoxFit.contain,
                          width: 35,
                          height: 35,
                        ),
                        onPressed: () => AuthService().signWithGoogle(),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        border: Border.all(
                          color: const Color.fromRGBO(
                              217, 217, 217, 8), // Change the border color
                          width: 2.0, // Change the border width
                        ),
                      ),
                      child: IconButton(
                        icon: Image.asset(
                          'assets/images/facebook.png',
                          width: 35,
                          height: 35,
                          fit: BoxFit.contain,
                        ),
                        onPressed: () {
                          // Add Facebook signup logic here
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Login In',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Color.fromRGBO(255, 215, 0, 100),
                          color: Color.fromRGBO(255, 215, 0, 100),
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
