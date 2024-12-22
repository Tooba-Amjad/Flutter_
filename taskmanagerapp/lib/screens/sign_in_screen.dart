import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_services.dart'; // Update with your actual path
import 'home_screen.dart';
import 'sign_up.dart';
import '../widgets/custom_text_field.dart';
import 'forgot_password_screen.dart';
class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  // Sign in with Email/Password
  Future<void> _signInWithEmailPassword() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  // Sign in with Google
  Future<void> _signInWithGoogle() async {
    User? user = await _authService.signInWithGoogle();
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google sign-in failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              controller: _emailController,
              labelText: 'Email',
            ),
            SizedBox(height: 16.0),
            CustomTextField(
              controller: _passwordController,
              labelText: 'Password',
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                );
              },
              child: Text("Forgot Password?", style: TextStyle(color: Colors.blue)),
            ),

            ElevatedButton(
              onPressed: _signInWithEmailPassword,
              child: Text('Sign In with Email/Password'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton.icon(
              onPressed: _signInWithGoogle,
              icon: Icon(Icons.login),
              label: Text('Sign in with Google'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
              child: Text('Don\'t have an account? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
