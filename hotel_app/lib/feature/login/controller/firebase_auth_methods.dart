import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hotel_app/core/utils/showOtpDialog.dart';
import 'package:hotel_app/core/utils/showSnackbar.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  //user
  User get user => _auth.currentUser!;

  // state
  Stream<User?> get authState => _auth.authStateChanges();

  //Email
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user data to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'uid': userCredential.user!.uid,
        'name': userCredential.user!.displayName,
        'phone': userCredential.user!.phoneNumber,
        'email': userCredential.user!.email,
        'email_verified': userCredential.user!.emailVerified,
        'profile_pic': userCredential.user!.photoURL,
      });

      await sendEmailVerification(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      showSnackBar(
          context, e.message!); // Displaying the usual firebase error message
    }
  }

  // Email login
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // If email is verified, update the 'email_verified' field in Firestore
      if (userCredential.user!.emailVerified) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .update({'email_verified': true});
      } else {
        sendEmailVerification(context);
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  // Email verification
  sendEmailVerification(BuildContext context) async {
    try {
      await _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, 'Verification email sent');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  Future<void> signInWithPhone({
    required String phoneNumber,
    required BuildContext context,
  }) async {
    try {
      TextEditingController codeController = TextEditingController();
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          showSnackBar(context, e.message!);
        },
        codeSent: (String verificationId, int? resendToken) async {
          showOTPDialog(
            context: context,
            codeController: codeController,
            onPressed: () async {
              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                verificationId: verificationId,
                smsCode: codeController.text.trim(),
              );
              UserCredential userCredential =
                  await _auth.signInWithCredential(credential);

              // Check if user exists in Firestore
              DocumentReference userRef = FirebaseFirestore.instance
                  .collection('users')
                  .doc(userCredential.user!.uid);

              DocumentSnapshot userSnapshot = await userRef.get();

              // If the user does not exist, save the new user data
              if (!userSnapshot.exists) {
                await userRef.set({
                  'uid': userCredential.user!.uid,
                  'name': userCredential.user!.displayName,
                  'phone': userCredential.user!.phoneNumber,
                  'email': userCredential.user!.email,
                  'email_verified': userCredential.user!.emailVerified,
                  'profile_pic': userCredential.user!.photoURL,
                });
              }

              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          showSnackBar(context, 'Time out');
        },
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  // phone verification

  // login with google
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth!.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        if (userCredential.user != null) {
          if (userCredential.additionalUserInfo!.isNewUser) {
            // to store data in firestore
            await FirebaseFirestore.instance
                .collection('users')
                .doc(userCredential.user!.uid)
                .set({
              'uid': userCredential.user!.uid,
              'name': userCredential.user!.displayName,
              'phone': userCredential.user!.phoneNumber,
              'email': userCredential.user!.email,
              'email_verified': userCredential.user!.emailVerified,
              'profile_pic': userCredential.user!.photoURL,
            });
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //sign out
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //delete account
  Future<void> deleteAccount(BuildContext context) async {
    try {
      User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        // Delete the user data in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .delete();

        // Delete the user account
        await currentUser.delete();
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //reset password
  Future<void> resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      showSnackBar(context, 'Password reset email sent');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //update display  name
  Future<void> updateDisplayName({
    required String displayName,
    required BuildContext context,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'name': displayName});
      await _auth.currentUser!.updateDisplayName(displayName);
      showSnackBar(context, 'Display name updated');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //add email and password provider to current user
  Future<void> linkEmailPasswordAccount({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      User? currentUser = _auth.currentUser;
      print('im triggered');

      if (currentUser != null) {
        print('im inside');
        // Link the email/password credential to the current user
        AuthCredential credential =
            EmailAuthProvider.credential(email: email, password: password);
        await currentUser.linkWithCredential(credential);
        sendEmailVerification(context);
        // Update the 'email_verified' field in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .update({'email_verified': false});
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  Future<void> linkWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth!.accessToken,
          idToken: googleAuth.idToken,
        );

        // Link the Google account to the current user
        User currentUser = _auth.currentUser!;
        await currentUser.linkWithCredential(credential);

        // Update Firestore data
        DocumentReference userRef =
            FirebaseFirestore.instance.collection('users').doc(currentUser.uid);

        await userRef.update({
          'uid': currentUser.uid,
          'name': currentUser.displayName,
          'phone': currentUser.phoneNumber,
          'email': currentUser.email,
          'email_verified': currentUser.emailVerified,
          'profile_pic': currentUser.photoURL,
        });

        showSnackBar(context, 'Google account linked');
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //remove google provider from current user
  Future<void> unlinkGoogleAccount(BuildContext context) async {
    try {
      User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        // Unlink the Google Sign In credential from the current user
        await currentUser.unlink('google.com');
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  ///link phone provider to current user
  Future<void> linkPhoneAccount({
    required String phoneNumber,
    required BuildContext context,
  }) async {
    try {
      TextEditingController codeController = TextEditingController();

      User? currentUser = user;

      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await currentUser.linkWithCredential(credential);
          showSnackBar(context, 'Phone account linked');
        },
        verificationFailed: (FirebaseAuthException e) {
          showSnackBar(context, e.message!);
        },
        codeSent: (String verificationId, int? resendToken) async {
          showOTPDialog(
            context: context,
            codeController: codeController,
            onPressed: () async {
              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                verificationId: verificationId,
                smsCode: codeController.text.trim(),
              );
              // Link the phone number with the current user account
              await currentUser.linkWithCredential(credential);
              codeController.dispose();

              // Update Firestore with the new phone number
              DocumentReference userRef = FirebaseFirestore.instance
                  .collection('users')
                  .doc(currentUser.uid);

              await userRef.update({
                'phone': phoneNumber,
              });

              Navigator.of(context).pop();
              showSnackBar(context, 'Phone account linked');
            },
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          showSnackBar(context, 'Time out');
        },
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //remove email and password provider from current user
  Future<void> removeEmailAndPassword(BuildContext context) async {
    try {
      User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        // Unlink the email/password credential from the current user
        await currentUser.unlink('password');
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  //remove phone provider from current user
  Future<void> removePhone(BuildContext context) async {
    try {
      User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        // Unlink the phone credential from the current user
        await currentUser.unlink('phone');
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }
}
