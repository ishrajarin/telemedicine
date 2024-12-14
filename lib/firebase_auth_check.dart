import 'package:flutter/material.dart';
import 'login.dart';
import 'home.dart';
import './firebase_auth/auth_service.dart';

class FirebaseAuthCheck extends StatelessWidget {
  FirebaseAuthCheck({Key? key}) : super(key: key);

  final AuthService _authService = AuthService();

  Future<bool> checkLoginStatus() async {
    return await _authService.checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('An error occurred: ${snapshot.error}'),
            ),
          );
        } else if (snapshot.hasData && snapshot.data == true) {
          return const HomePage();
        } else {
          return const Login();
        }
      },
    );
  }
}
// TODO Implement this library.