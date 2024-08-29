import 'package:flutter/material.dart';

class DashboardEvent {}

class LoginWithEmailPasswordEvent extends DashboardEvent {
  LoginWithEmailPasswordEvent({required this.email,required this.password});
  String  email;
  String password;
}
class SignupWithEmailPasswordEvent extends DashboardEvent {
  SignupWithEmailPasswordEvent({required this.email, required this.password,required this.userName});
  String email;
  String password;
  String userName;
}

class SignInWithGoogleEvent extends DashboardEvent {}

