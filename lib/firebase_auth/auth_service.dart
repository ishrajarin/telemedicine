import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart' as model;

class AuthService {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;

  /// Check if a user is logged in
  Future<bool> checkLoginStatus() async {
    firebase_auth.User? user = _auth.currentUser;
    return user != null;
  }

  /// Check if the user's email is verified
  Future<bool> isEmailVerified() async {
    firebase_auth.User? user = _auth.currentUser;
    await user?.reload(); // Reload user to get the latest email verification status
    user = _auth.currentUser;
    return user?.emailVerified ?? false;
  }

  /// Login with email and password
  Future<bool> login(String email, String password) async {
    try {
      firebase_auth.UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      firebase_auth.User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        bool emailVerified = await isEmailVerified();
        if (!emailVerified) {
          await _auth.signOut();
          throw Exception('Email not verified. Please verify your email.');
        }

        // Save user details
        model.UserCredentials().email = firebaseUser.email ?? '';
        model.UserCredentials().displayName = firebaseUser.displayName ?? '';
        model.UserCredentials().uid = firebaseUser.uid;
        model.UserCredentials().profilePicUrl = firebaseUser.photoURL ?? '';
        await model.UserCredentials().saveToPreferences();

        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('Login error: $e');
      throw Exception('Login failed: $e');
    }
  }

  /// Login with Google
  Future<model.User> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final firebase_auth.UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      final firebase_auth.User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        model.UserCredentials().email = firebaseUser.email ?? '';
        model.UserCredentials().uid = firebaseUser.uid;
        model.UserCredentials().displayName = firebaseUser.displayName ?? '';
        model.UserCredentials().profilePicUrl = firebaseUser.photoURL ?? '';
        await model.UserCredentials().saveToPreferences();

        return model.User(
          uid: firebaseUser.uid,
          email: firebaseUser.email ?? '',
          displayName: firebaseUser.displayName ?? '',
          profilePicUrl: firebaseUser.photoURL ?? '',
        );
      } else {
        throw Exception('Failed to sign in with Google.');
      }
    } catch (e) {
      debugPrint('Google Sign-In error: $e');
      throw Exception('Google Sign-In failed: $e');
    }
  }

  /// Register a new user
  Future<void> registerUser({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      firebase_auth.UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(email: email, password: password);

      firebase_auth.User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        await firebaseUser.updateDisplayName(fullName);
        await firebaseUser.sendEmailVerification();

        // Save user details
        model.User user = model.User(
          uid: firebaseUser.uid,
          email: firebaseUser.email ?? '',
          displayName: fullName,
          profilePicUrl: '',
        );

        model.UserCredentials userCredentials = model.UserCredentials();
        userCredentials.email = user.email;
        userCredentials.uid = user.uid;
        userCredentials.displayName = user.displayName;
        userCredentials.profilePicUrl = user.profilePicUrl;
        await userCredentials.saveToPreferences();
      }
    } catch (e) {
      debugPrint('Registration error: $e');
      throw Exception('Registration failed: $e');
    }
  }

  /// Logout
  Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
  }
}
