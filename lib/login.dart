// ignore_for_file: use_build_context_synchronously

import 'package:user_fier_auth/dashbord/dashboard_bloc.dart';
import 'package:user_fier_auth/dashbord/dashboard_event.dart';
import 'package:user_fier_auth/dashbord/dashboard_state.dart';
import 'package:user_fier_auth/forgot_password.dart';
import 'package:user_fier_auth/home.dart';
import 'package:user_fier_auth/service/auth.dart';
import 'package:user_fier_auth/signup.dart';
import 'package:user_fier_auth/utils/common_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String email = "", password = "";
final DashboardBloc _bloc = DashboardBloc();
  TextEditingController mailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child:  BlocConsumer<DashboardBloc, DashboardState>(
          bloc: _bloc,
          listener: _stateListener,
          builder: (BuildContext context, DashboardState state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        "images/car.PNG",
                        fit: BoxFit.cover,
                      )),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          Container(
                            padding:
                                const EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                            decoration: BoxDecoration(
                                color: const Color(0xFFedf0f8),
                                borderRadius: BorderRadius.circular(30)),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter E-mail';
                                }
                                return null;
                              },
                              controller: mailcontroller,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                      color: Color(0xFFb2b7bf), fontSize: 18.0)),
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                            decoration: BoxDecoration(
                                color: const Color(0xFFedf0f8),
                                borderRadius: BorderRadius.circular(30)),
                            child: TextFormField(
                              controller: passwordcontroller,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Password';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                      color: Color(0xFFb2b7bf), fontSize: 18.0)),
                         obscureText: true,   ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          GestureDetector(
                            onTap: (){
                              if(_formkey.currentState!.validate()){
                                setState(() {
                                  email= mailcontroller.text;
                                  password=passwordcontroller.text;
                                });
                              }
                              //userLogin();
                              _bloc.add(LoginWithEmailPasswordEvent(email: mailcontroller.text,password: passwordcontroller.text));
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 13.0, horizontal: 30.0),
                                decoration: BoxDecoration(
                                    color: const Color(0xFF273671),
                                    borderRadius: BorderRadius.circular(30)),
                                child: const Center(
                                    child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w500),
                                ))),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const ForgotPassword()));
                    },
                    child: const Text("Forgot Password?",
                        style: TextStyle(
                            color: Color(0xFF8c8e98),
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  const Text(
                    "or LogIn with",
                    style: TextStyle(
                        color: Color(0xFF273671),
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){
                         // AuthMethods().signInWithGoogle(context);
                         _bloc.add(SignInWithGoogleEvent());

                        },
                        child: Image.asset(
                          "images/google.png",
                          height: 45,
                          width: 45,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 30.0,
                      ),
                      GestureDetector(
                        onTap: (){
                          AuthMethods().signInWithApple();
                         
                        },
                        child: Image.asset(
                          "images/apple1.png",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?",
                          style: TextStyle(
                              color: Color(0xFF8c8e98),
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(
                        width: 5.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const SignUp()));
                        },
                        child: const Text(
                          "SignUp",
                          style: TextStyle(
                              color: Color(0xFF273671),
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
        }
      ),
    );
  }

  void _stateListener(BuildContext context, DashboardState state) {
    if (state is SuccessState) {
      showSuccess(state.scessMessage ?? '', context);
       Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home()));
    } else if (state is ErrorState) {
      showError(state.errorMessage ?? '', context);
    }
  }
}


