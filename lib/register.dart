import 'package:flutter/material.dart';
import 'package:tele_medicine/firebase_auth_check.dart';
import 'firebase_auth/auth_service.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  final AuthService _auth = AuthService();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _registerUser() async {
    setState(() {
      _isLoading = true;
    });

    try {
      if (_fullNameController.text.isEmpty) {
        throw 'Full Name cannot be empty';
      } else if (_emailController.text.isEmpty) {
        throw 'Email cannot be empty';
      } else if (_passwordController.text.isEmpty) {
        throw 'Password cannot be empty';
      }

      //Check email format
      final email = _emailController.text;
      final emailPattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailPattern.hasMatch(email)) {
        throw 'Invalid email format';
      }

      // Check password format to have a strong password
      final password = _passwordController.text;
      final passwordPattern =
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,15}$');
      if (!passwordPattern.hasMatch(password)) {
        throw 'Password must contain at least 1 uppercase letter, 1 lowercase letter, 1 number, 1 special character, and be 8-15 characters long';
      }

      if (_passwordController.text != _confirmPasswordController.text) {
        throw 'Passwords do not match';
      }

      await _auth.registerUser(
        fullName: _fullNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (context.mounted) {
        // Show a dialog to inform the user to verify their email
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Verify your email'),
            content: const Text(
                'A verification link has been sent to your email. Please verify your email before logging in.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => FirebaseAuthCheck()),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        // Show an error message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: $e')),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Full-screen image
          Positioned.fill(
            child: Image.asset(
              'assets/images/loginRegister_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // Positioned button
          Positioned(
            top: 40,
            left: 20,
            child: GestureDetector(
              onTap: () {
                // Handle close action
                Navigator.pop(context
                  // Pop back to previous navigate screen
                  // **REMARK: ALL SCREEN NAVIGATE TO REGISTER MUST NOT USE PUSH REPLACEMENT!!!**
                );
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          Center(
            child: Container(
              width: 300,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.69),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFA4A5FF),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _fullNameController,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      labelStyle: TextStyle(
                        color: Color(0xFFA4A5FF),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(
                              0xFFA4A5FF), // Set the desired color for the border
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(
                              0xFFA4A5FF), // Set the desired color for the enabled border
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(
                              0xFFA4A5FF), // Set the desired color for the focused border
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Color(0xFFA4A5FF),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: Color(0xFFA4A5FF),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(
                              0xFFA4A5FF), // Set the desired color for the border
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(
                              0xFFA4A5FF), // Set the desired color for the enabled border
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(
                              0xFFA4A5FF), // Set the desired color for the focused border
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Color(0xFFA4A5FF),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(
                        color: Color(0xFFA4A5FF),
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(
                              0xFFA4A5FF), // Set the desired color for the border
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(
                              0xFFA4A5FF), // Set the desired color for the enabled border
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(
                              0xFFA4A5FF), // Set the desired color for the focused border
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Color(0xFFA4A5FF),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: const Color(0xFFA4A5FF),
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: !_isConfirmPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      labelStyle: const TextStyle(
                        color: Color(0xFFA4A5FF),
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(
                              0xFFA4A5FF), // Set the desired color for the border
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(
                              0xFFA4A5FF), // Set the desired color for the enabled border
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(
                              0xFFA4A5FF), // Set the desired color for the focused border
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Color(0xFFA4A5FF),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: const Color(0xFFA4A5FF),
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordVisible =
                            !_isConfirmPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Handle register action
                      _registerUser();
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                          color: Color(0xFFA4A5FF)), // Change text color),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.white.withOpacity(0.69),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFFA4A5FF)), // Change this color as needed
                ),
              ),
            ),
        ],
      ),
    );
  }
}
