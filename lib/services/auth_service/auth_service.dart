import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../models/models.dart';
import '../services.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  DataBaseService dbService = DataBaseService();
  SnackBarService snackBarService = SnackBarService();

  // ^ Login with Email and Password

  Future<({bool isSuccess, UserModel? userModel})> loginUser({
    required String email,
    required String password,
  }) async {
    log('email -----------------------------> $email');
    log('Password -----------------------------> $password');
    if (email.isEmpty || password.isEmpty) {
      snackBarService.showSnackbar(
        message: "Please Enter Correct Credentials",
        duration: 2,
        title: "Wrong Credentials",
        color: Colors.red,
      );
      return (isSuccess: false, userModel: null);
    } else {
      try {
        log("came to Login");
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: email, password: password);

        String uid = userCredential.user!.uid;

        User? currentUser = FirebaseAuth.instance.currentUser;

        if (currentUser != null) {
          UserModel? currentUser = await DataBaseService.getUserbyUid(uid);
          snackBarService.showSnackbar(
            message: "Welcome Back ${currentUser!.email}",
            duration: 2,
            title: "Login Successfull",
            color: Colors.green,
          );

          return (isSuccess: true, userModel: currentUser);
        } else {
          snackBarService.showSnackbar(
            message: "Please Enter Correct Credentials",
            duration: 2,
            title: "Wrong Credentials",
            color: Colors.red,
          );

          return (isSuccess: false, userModel: null);
        }
      } catch (e, stackTrace) {
        snackBarService.showSnackbar(
          message: e.toString(),
          duration: 2,
          title: "Wrong Credentials",
          color: Colors.red,
        );
        log('error : ${e.toString()}');
        log('stackTrace : ${stackTrace.toString()}');
        return (isSuccess: false, userModel: null);
      }
    }
  }

// ^ Signup User
  Future<bool> signupUserWithEmailPassword({
    required String userEmail,
    required String userPassword,
    required String confirmPassword,
  }) async {
    log('came 1 to signup  ');
    if (userEmail.isEmpty ||
        userPassword.isEmpty ||
        userPassword != confirmPassword) {
      snackBarService.showSnackbar(
        message: "Please Enter Correct Credentials",
        duration: 2,
        title: "Wrong Credentials",
        color: Colors.red,
      );
      return false;
    } else {
      try {
        var userCredential = await auth.createUserWithEmailAndPassword(
            email: userEmail, password: userPassword);
        log('came 2 to signup  ');

        log(userCredential.user!.email.toString());

        User? user = userCredential.user;
        log('came 3 to signup  ');

        if (user != null) {
          UserModel newUserMode = UserModel(
              uid: userCredential.user!.uid,
              availableDiamonds: 5,
              bgRemovedImageLinks: [],
              email: user.email!,
              totalAds: 0,
              totalBgRemoved: 0);
          log('came 4 to signup  ');

          var result =
              await DataBaseService().addUserToFireStore(userData: newUserMode);

          log('came 5 to signup  ');

          if (result == true) {
            snackBarService.showSnackbar(
                message: "Welcome to Inventory Object",
                duration: 3,
                title: 'Signup Successful');
            return true;
          }
        }

        return false;
      } on FirebaseException catch (e) {
        snackBarService.showSnackbar(
            message: e.message.toString(),
            duration: 2,
            title: 'Signup Failed',
            color: Colors.red);
        return false;
      } catch (e, stackTrace) {
        log('Error : ${e.toString()}\n\n');
        log('stackTrace : ${stackTrace.toString()}');
        return false;
      }
    }
  }

// ^ Google Sign IN
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/userinfo.profile',
  ], hostedDomain: 'gmail.com');

  Future<({bool? res, UserModel? user})> signInwithGoogle() async {
    try {
      log("Hello 1");
      // final GoogleSignInAccount? googleUser =
      await _googleSignIn.signIn();
      log("Hello 2");

      final GoogleSignInAccount? currentUser = _googleSignIn.currentUser;

      if (currentUser != null) {
        log("User is already signed in");

        final GoogleSignInAuthentication googleAuth =
            await currentUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        User? user = userCredential.user;

        if (user != null) {
// ~ is New User
          if (userCredential.additionalUserInfo!.isNewUser) {
            UserModel newUser = UserModel(
              availableDiamonds: 0,
              bgRemovedImageLinks: [],
              email: user.email!,
              totalAds: 0,
              totalBgRemoved: 0,
              uid: user.uid,
            );
            var result = await dbService.addUserToFireStore(userData: newUser);

            if (result == true) {
              snackBarService.showSnackbar(
                  message: "You have been logged in",
                  duration: 2,
                  title: 'Welcome OnBoard');

              return (res: true, user: newUser);
            } else {
              return (res: false, user: null);
            }
          } else {
            // ^ Old User

            //  var user = await

            final oldUser = await DataBaseService.getUserbyUid(user.uid);
            return (res: true, user: oldUser);
          }

          // Get.to(() => HomePage(userModel: userProvider.userModel!));
        }
        return (res: false, user: null);
      }

      return (res: false, user: null);
    }
    //  on FirebaseAuthException catch (e) {
    //   log(e.message.toString());
    //   return (res: false, user: null);
    // }
    catch (e, stackTrace) {
      log('Error : ${e.toString()}\n\n');
      log('stackTrace : ${stackTrace.toString()}');
      return (res: false, user: null);
    }
  }

  //  ^  Signout

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await auth.signOut();
  }
}
