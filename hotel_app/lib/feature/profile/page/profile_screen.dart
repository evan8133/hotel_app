import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/core/router/router.gr.dart';
import 'package:provider/provider.dart';

import '../../login/controller/firebase_auth_methods.dart';
import '../../login/widget/custom_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static const String name = 'profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _updateName(BuildContext context, String name) async {
    final newName = await showTextInputDialog(
      context: context,
      title: 'Update Name',
      textFields: [
        DialogTextField(
          initialText: name,
          hintText: 'Enter your name',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
            if (value.length < 3) {
              return 'Name must be at least 3 characters long';
            }
            if (value.length > 20) {
              return 'Name must be less than 20 characters long';
            }
            if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
              return 'Name must contain only alphabetic characters and spaces';
            }
            return null;
          },
        ),
      ],
    );

    if (newName != null && newName.isNotEmpty) {
      context
          .read<FirebaseAuthMethods>()
          .updateDisplayName(context: context, displayName: newName.first)
          .then((value) {
        setState(() {});
      });
    }
  }

  Future<void> _confirmUnlinkGoogle(BuildContext context) async {
    final confirmed = await showOkCancelAlertDialog(
      context: context,
      title: 'Unlink Google Account',
      message: 'Are you sure you want to unlink your Google account?',
      okLabel: 'Yes',
      cancelLabel: 'Cancel',
    );

    if (confirmed == OkCancelResult.ok) {
      context.read<FirebaseAuthMethods>().unlinkGoogleAccount(context).then(
        (_) {
          setState(() {});
        },
        onError: (e) {
          showAlertDialog(
            context: context,
            title: 'Error',
            message: e.toString(),
          );
        },
      );
    }
  }

  Future<void> _linkGoogleAccount(BuildContext context) async {
    context.read<FirebaseAuthMethods>().linkWithGoogle(context).then(
      (_) {
        setState(() {});
      },
      onError: (e) {
        showAlertDialog(
          context: context,
          title: 'Error',
          message: e.toString(),
        );
      },
    );
  }

  Future<void> _addEmail(BuildContext context, String email) async {
    final result = await showTextInputDialog(
      context: context,
      title: 'Add Email',
      textFields: [
        DialogTextField(
          initialText: email,
          hintText: 'Enter your email',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
        DialogTextField(
          hintText: 'Enter your password',
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters long';
            }
            return null;
          },
        ),
      ],
    );

    if (result != null) {
      final email = result[0];
      final password = result[1];
      context
          .read<FirebaseAuthMethods>()
          .linkEmailPasswordAccount(
              email: email, password: password, context: context)
          .then((value) {
        setState(() {});
      });
    }
  }

  Future<void> _addPhoneNumber(BuildContext context) async {
    String? phoneNumber;

    final result = await showTextInputDialog(
      context: context,
      title: 'Phone Number',
      textFields: [
        DialogTextField(
          initialText: '+964',
          hintText: 'Enter your Phone Number',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your phone number';
            }
            if (!RegExp(r'^\+964\d{10}$').hasMatch(value)) {
              return 'Please enter a valid phone number';
            }
            return null;
          },
        ),
      ],
    );

    if (result != null) {
      context
          .read<FirebaseAuthMethods>()
          .linkPhoneAccount(context: context, phoneNumber: result.first)
          .then((_) {
        setState(() {});
      });
      print("Phone number added/updated: $phoneNumber");
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;
    final isGoogleSignIn =
        user!.providerData.any((info) => info.providerId == 'google.com');

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 35,
            backgroundImage: user.photoURL != null
                ? NetworkImage(user.photoURL!)
                : const AssetImage('assets/images/default_profile_pic.png')
                    as ImageProvider,
          ),
          const SizedBox(height: 20),
          Text(
            user.displayName ?? 'No name',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(user.displayName ?? 'No name'),
            trailing: TextButton(
              onPressed: () =>
                  _updateName(context, user.displayName ?? 'No name'),
              child: const Text('Edit Name'),
            ),
          ),
          if (isGoogleSignIn)
            ListTile(
              leading: const Icon(Icons.email),
              title: Text(user.email ?? 'No email'),
              trailing: user.email == null
                  ? TextButton(
                      onPressed: () {},
                      child: const Text('Add Email'),
                    )
                  : IconButton(
                      onPressed: () => _confirmUnlinkGoogle(context),
                      icon: const Icon(
                        Icons.remove_circle,
                      ),
                    ),
            ),
          if (!isGoogleSignIn)
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text('Link Google Account'),
              trailing: IconButton(
                onPressed: () => _linkGoogleAccount(context),
                icon: const Icon(
                  Icons.add_circle,
                ),
              ),
            ),
          if (isGoogleSignIn)
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Google Sign-In'),
              trailing: Image.asset(
                'assets/images/google_logo.png',
                width: 24,
              ),
            ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: Text(user.providerData.first.email ?? 'No email'),
            trailing: TextButton(
              onPressed: () => _addEmail(
                  context, user.providerData.first.email ?? 'No email'),
              child: const Text('Add Email'),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: Text(user.phoneNumber ?? 'No phone number'),
            trailing: TextButton(
              onPressed: () => _addPhoneNumber(context),
              child: Text(user.phoneNumber != null ? 'Change' : 'Add'),
            ),
          ),
          if (!user.emailVerified)
            CustomButton(
              onTap: () {
                context
                    .read<FirebaseAuthMethods>()
                    .sendEmailVerification(context);
              },
              text: 'Verify Email',
            ),
          CustomButton(
            onTap: () {
              context.read<FirebaseAuthMethods>().signOut(context).then((value) => context.router.replace(const LoginRoute()));
            },
            text: 'Sign Out',
          ),
          CustomButton(
            onTap: () {
              context.read<FirebaseAuthMethods>().deleteAccount(context);
            },
            text: 'Delete Account',
          ),
        ],
      ),
    );
  }
}
