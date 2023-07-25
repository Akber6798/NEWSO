import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
  static Routes instance = Routes();

  //* for push repalcement navigation
  Future<dynamic> pushReplaceMent(
      {required BuildContext context, required Widget newScreen}) {
    return Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: newScreen,
      ),
    );
  }

  //* for push navigation
  Future<dynamic> push(
      {required BuildContext context, required Widget newScreen}) {
    return Navigator.push(
      context,
      PageTransition(
        duration: const Duration(milliseconds: 300),
        type: PageTransitionType.rightToLeft,
        child: newScreen,
      ),
    );
  }

  //* signin function navigation
   Future<dynamic> signInPusH(
      {required BuildContext context, required Widget newScreen}) {
    return Navigator.pushReplacement(
      context,
      PageTransition(
        duration: const Duration(milliseconds: 400),
        type: PageTransitionType.fade,
        child: newScreen,
      ),
    );
}
}