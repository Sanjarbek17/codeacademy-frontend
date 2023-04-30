// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});
  static const routeName = 'login-screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String assetImage = 'https://telegra.ph/file/9aa2770b195550c2b113a.png';

  bool isvisible = true;
  String errorMessage = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final borderRadiusM = MediaQuery.of(context).size.width * 0.016 + MediaQuery.of(context).size.height * 0.016;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final animatedTextStyle = GoogleFonts.adamina(
      fontSize: borderRadiusM,
      fontWeight: FontWeight.w900,
      letterSpacing: 8,
    );
    return Scaffold(
      backgroundColor: Color(0xFFE0EDFE),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    color: Colors.transparent,
                    width: width * 0.47,
                    height: height * 0.7,
                    child: Column(
                      children: [
                        SizedBox(
                          width: width * 0.4,
                          height: height * 0.3,
                          child: Image.network(
                            assetImage,
                            // fit: BoxFit.fitHeight,
                          ),
                        ),
                        SizedBox(
                          height: borderRadiusM * 2,
                        ),
                        AnimatedTextKit(
                          repeatForever: true,
                          animatedTexts: [
                            TyperAnimatedText(
                              'WELCOME  TO\nCODEACADEMY',
                              textStyle: animatedTextStyle,
                              speed: const Duration(milliseconds: 100),
                              textAlign: TextAlign.center,
                            ),
                            RotateAnimatedText(
                              'CODEACADEMY',
                              textStyle: animatedTextStyle,
                            ),
                            WavyAnimatedText(
                              'CODEACADEMY',
                              textStyle: animatedTextStyle,
                            )
                          ],
                        ),
                      ],
                    )
                    // Image.asset(
                    //   assetImage,
                    //   fit: BoxFit.fitHeight,
                    // ),
                    ),
                Container(
                  height: height,
                  width: width * 0.53,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadiusM),
                      bottomLeft: Radius.circular(borderRadiusM),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: borderRadiusM + 20,
                      left: borderRadiusM * 2,
                      right: borderRadiusM * 2,
                      bottom: borderRadiusM,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                            color: Color(0xFF002642),
                            fontWeight: FontWeight.bold,
                            fontSize: borderRadiusM,
                          ),
                        ),
                        SizedBox(
                          height: borderRadiusM / 3.8,
                        ),
                        Text(
                          'Please login to continue',
                          style: TextStyle(
                            color: Color(0xFF002642),
                            fontWeight: FontWeight.w500,
                            fontSize: borderRadiusM / 2.2,
                          ),
                        ),
                        SizedBox(
                          height: borderRadiusM * 3,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please, enter your username!';
                            } else if (errorMessage == 'Error') {
                              return 'Incorrect username or password';
                            }
                            return null;
                          },
                          controller: usernameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Email',
                          ),
                        ),
                        SizedBox(
                          height: borderRadiusM,
                        ),
                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please, enter your password!';
                            } else if (errorMessage == 'Error') {
                              return 'Incorrect username or password';
                            }
                            return null;
                          },
                          obscureText: isvisible,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Password',
                            suffixIcon: IconButton(
                              icon: isvisible == true
                                  ? const Icon(
                                      Icons.visibility,
                                      color: Colors.grey,
                                    )
                                  : const Icon(
                                      Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                              onPressed: () {
                                setState(() {
                                  isvisible = !isvisible;
                                });
                              },
                            ),
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Row(
                          children: [
                            Spacer(),
                            TextButton(
                              onPressed: () {},
                              child: Text('Forgot Password'),
                            ),
                          ],
                        ),
                        Spacer(
                          flex: 4,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: height * 0.055,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.goNamed(
                                  HomeScreen.routeName,
                                );
                              }
                              return;
                            },
                            child: Text('Login'),
                          ),
                        ),
                        Spacer(
                          flex: 8,
                        ),
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              "Or",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              "Login with",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                        Spacer(
                          flex: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.all(8),
                              width: borderRadiusM,
                              height: borderRadiusM,
                              child: Image.asset('google_logo.png'),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.all(8),
                              width: borderRadiusM,
                              height: borderRadiusM,
                              child: Image.asset('github_logo.png'),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.all(8),
                              width: borderRadiusM,
                              height: borderRadiusM,
                              child: Image.asset('codewars_logo.png'),
                            ),
                          ],
                        ),
                        Spacer(
                          flex: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
