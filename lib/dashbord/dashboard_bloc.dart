import 'dart:async';
import 'dart:math';
import 'package:user_fier_auth/dashbord/dashboard_event.dart';
import 'package:user_fier_auth/dashbord/dashboard_state.dart';
import 'package:user_fier_auth/service/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardState()) {
    on<LoginWithEmailPasswordEvent>(_loginWithEmailPasswordEvent);
    on<SignInWithGoogleEvent>(_signInWithGoogleEvent);
    on<SignupWithEmailPasswordEvent>(_signupWithEmailPasswordEvent);
  }

  Future<void> _loginWithEmailPasswordEvent(
      LoginWithEmailPasswordEvent event, Emitter<DashboardState> emit) async {
    try {
      UserCredential data = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: event.email, password: event.password);
      print('---------------------------------------------------');
      print(data);
      print('=======================================');
      emit(SuccessState(scessMessage: 'Success Login'));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(ErrorState(errorMessage: 'No User Found for that Email'));
      } else if (e.code == 'wrong-password') {
        emit(ErrorState(errorMessage: 'Wrong Password Provided by User'));
      } else if (e.code == 'invalid-credential') {
        emit(ErrorState(errorMessage: 'Invalid Credential by User'));
      }
    }
  }

  Future<void> _signupWithEmailPasswordEvent(
      SignupWithEmailPasswordEvent event, Emitter<DashboardState> emit) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: event.email, password: event.password);
      emit(SuccessState(scessMessage: 'Registered Successfully'));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(ErrorState(errorMessage: 'Password Provided is too Weak'));
      } else if (e.code == "email-already-in-use") {
        emit(ErrorState(errorMessage: 'Account Already exists'));
      }
    }
  }

  Future<void> _signInWithGoogleEvent(
      SignInWithGoogleEvent event, Emitter<DashboardState> emit) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication?.idToken,
          accessToken: googleSignInAuthentication?.accessToken);

      UserCredential result =
          await firebaseAuth.signInWithCredential(credential);

      User? userDetails = result.user;

      Map<String, dynamic> userInfoMap = {
        "email": userDetails!.email,
        "name": userDetails.displayName,
        "imgUrl": userDetails.photoURL,
        "id": userDetails.uid
      };
      print(userInfoMap);
      print('-------------------------------------------gogledetails');
      await DatabaseMethods().addUser(userDetails.uid, userInfoMap);
      emit(SuccessState(scessMessage: 'Success Login'));
    } on FirebaseAuthException catch (e) {
      emit(ErrorState(errorMessage: 'Invalid invalide '));
    }
  }
}
