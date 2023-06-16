import 'package:flutter/material.dart';
import 'package:hotel_app/feature/login/controller/firebase_auth_methods.dart';
import 'package:provider/provider.dart';

import '../widget/custom_textfield.dart';

class EmailPasswordSignupScreen extends StatefulWidget {
  static String routeName = 'signup-email-password';
  const EmailPasswordSignupScreen({Key? key}) : super(key: key);

  @override
  _EmailPasswordSignupState createState() => _EmailPasswordSignupState();
}

class _EmailPasswordSignupState extends State<EmailPasswordSignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signUpUser() {
    if (_formKey.currentState!.validate()) {
      context.read<FirebaseAuthMethods>().signUpWithEmail(
        email: emailController.text,
        password: passwordController.text,
        context: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign Up",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextField(
                  controller: nameController,
                  hintText: 'Enter your Name',
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'Please enter your name';
                    }
                    if (p0.length < 3) {
                      return 'Name must be at least 3 characters';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextField(
                  controller: phoneController,
                  hintText: 'Enter your Phone Number',
                  keyboardType: TextInputType.number,
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (p0.length < 10) {
                      return 'Phone number must be at least 10 characters';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextField(
                  controller: emailController,
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$")
                            .hasMatch(p0) ==
                        false) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextField(
                  isPassowrd: true,
                  controller: passwordController,
                  hintText: 'Enter your password',
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (p0.length < 8) {
                      return 'Password must be at least 6 characters';
                    }
                    if (RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$")
                            .hasMatch(p0) ==
                        false) {
                      return 'Password must contain at least one uppercase letter, one lowercase letter and one number';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextField(
                  isPassowrd: true,
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  validator: (p0) {
                    if (passwordController.text != p0) {
                      return 'Password does not match';
                    }
                    if (p0!.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (p0.length < 8) {
                      return 'Password must be at least 6 characters';
                    }
                    if (RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$")
                            .hasMatch(p0) ==
                        false) {
                      return 'Password must contain at least one uppercase letter, one lowercase letter and one number';
                    }
        
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: signUpUser,
                child: const Text(
                  "Sign Up",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
