// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newso/consts/routes.dart';
import 'package:newso/screens/homescreen/home_screen.dart';
import 'package:newso/screens/signinscreen/sign_in_screen.dart';
import 'package:newso/services/global_services.dart';

class AuthService {
  static AuthService instance = AuthService();

  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  //* to detect the user is loggedin or not
  Stream<User?> get getAuthChange => auth.authStateChanges();

  //*Sign in with google
  signUpWithGoogle(BuildContext context) async {
    GlobalServices.instance.showLoaderDialog(context);
    try {
      //* signup to google
      GoogleSignInAccount? googleSignAccount = await googleSignIn.signIn();
      if (googleSignAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);
        //* then sign to firebase
        try {
          await auth.signInWithCredential(credential);
          Navigator.pop(context);
          Routes.instance.signInPusH(
            context: context,
            newScreen: const HomeScreen(),
          );
        } catch (error) {
          Navigator.pop(context);
          GlobalServices.instance
              .errorDialogue(errorMessage: error.toString(), context: context);
        }
      } else {
        Navigator.pop(context);
        GlobalServices.instance
            .errorDialogue(errorMessage: "Unable to Sign in", context: context);
      }
    } on FirebaseAuthException catch (error) {
      GlobalServices.instance
          .errorDialogue(errorMessage: error.toString(), context: context);
    }
  }

  //* logout
  logOut(BuildContext context) {
    GlobalServices.instance.showLoaderDialog(context);
    try {
      auth.signOut();
      googleSignIn.signOut();
      Navigator.pop(context);
      Routes.instance.pushReplaceMent(
        context: context,
        newScreen: const SignInScreen(),
      );
    } on FirebaseAuthException catch (error) {
      GlobalServices.instance
          .errorDialogue(errorMessage: error.toString(), context: context);
    }
  }
}
