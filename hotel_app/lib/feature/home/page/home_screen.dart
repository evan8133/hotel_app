import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  static String routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);
  static const String name = '/home';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home'),
    );
  }
}
