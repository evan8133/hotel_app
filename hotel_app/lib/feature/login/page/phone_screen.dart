import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/custom_button.dart';
import '../widget/custom_textfield.dart';

class PhoneScreen extends StatefulWidget {
  static String routeName = '/phone';
  const PhoneScreen({Key? key}) : super(key: key);

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              controller: phoneController,
              hintText: 'Enter phone number',
            ),
            CustomButton(
              onTap: () {},
              text: 'OK',
            ),
          ],
        ),
      ),
    );
  }
}
