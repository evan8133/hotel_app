
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../Navigation/navigation.dart';
import '../login/page/login_screen.dart';
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);
  static const String name = '/';    

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      return const NavigationPages();
    } else {
      return const LoginScreen();
    }
  }
}
