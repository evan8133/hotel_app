import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/feature/login/page/phone_screen.dart';
import 'package:hotel_app/feature/login/page/signup_email_password_screen.dart';
import 'package:provider/provider.dart';
import '../../../core/router/router.gr.dart';
import '../controller/firebase_auth_methods.dart';
import '../widget/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = '/login-email-password';
  const LoginScreen({Key? key}) : super(key: key);
  static const String name = 'login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void loginUser() async {
    context
        .read<FirebaseAuthMethods>()
        .loginWithEmail(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          context: context,
        )
        .then((value) => context.router.replace(const NavigationRoute()));
  }
@override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Hotel Booking'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Login",
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: emailController,
              hintText: 'Enter your email',
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: passwordController,
              hintText: 'Enter your password',
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: loginUser,
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(
                Size(MediaQuery.of(context).size.width / 2.5, 50),
              ),
            ),
            child: const Text(
              "Login",
            ),
          ),
          const SizedBox(height: 20),
          Divider(),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    // context.router.push(SignupEmailPasswordRoute());
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                        ),
                        child: const Icon(
                          Icons.email,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text("Email Sign Up"),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    //context.router.push(const PhoneRoute());
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                        ),
                        child: const Icon(
                          Icons.phone,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text("Phone Sign In"),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await context
                        .read<FirebaseAuthMethods>()
                        .signInWithGoogle(context);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                        ),
                        child: const Icon(
                          Icons.login,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text("Google Sign In"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
