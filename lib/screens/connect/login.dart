import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wedding_planner/classes/Helpers.dart';
import 'package:wedding_planner/screens/pages/homeScreen.dart';
import 'package:wedding_planner/style/Theme.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _validateEmail = false, _validatePass = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((data) {
      if (data != null) {
        Navigator.pushReplacementNamed(context, '/');
      }
    });

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop){
        FlutterExitApp.exitApp();
      },
      child: Scaffold(
          body: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if(snapshot.hasError) {
                  return const Text("Something went wrong");
                }

                if(snapshot.hasData) { //if there is data
                  Fluttertoast.showToast(msg: "Already signed in");
                  print('already signed \n\n\n');
                  return const HomeScreen();
                }
                else {
                  return LoginWidget(context);
                }

              }
          )
      ),
    );
  }

  Widget LoginWidget(context){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 220,
            child: FadeInUp(
                duration: const Duration(milliseconds: 1600),
                child: Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: gold,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )),
          ),
          const SizedBox(
              height: 100,
              child: Image(
                image: AssetImage('assets/images/wedding.png'),
              )),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                FadeInUp(
                    duration:
                    const Duration(milliseconds: 1800),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.circular(10),
                          border: Border.all(color: gold),
                          boxShadow: [
                            BoxShadow(
                                color: goldAccent,
                                blurRadius: 20.0,
                                offset: const Offset(0, 10))
                          ]),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: gold))),
                            child: TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email",
                                  errorText: _validateEmail ?
                                  "This field can't be empty" : null,
                                  hintStyle: TextStyle(
                                      color: Colors.grey[700])),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  errorText: _validatePass ?
                                  "This field can't be empty" : null,
                                  hintStyle: TextStyle(
                                      color: Colors.grey[700])),
                            ),
                          )
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 30,
                ),
                FadeInUp(
                    duration:
                    const Duration(milliseconds: 1900),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(10),
                          gradient: LinearGradient(
                              colors: [dun, goldAccent])),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _validateEmail = _emailController.text.isEmpty;
                            _validatePass = _passwordController.text.isEmpty;
                          });
                          if (!_validateEmail && !_validatePass) {
                            SignIn(
                                _emailController.text,
                                _passwordController.text,
                                context);
                          }
                        },
                        child: const Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )),

                FadeInUp(
                    duration:
                    const Duration(milliseconds: 2000),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(color: gold),
                      ),
                    )),

                FadeInUp(
                    duration:
                    const Duration(milliseconds: 1700),
                    child: const Text(
                      "Continue with other options",
                      style: TextStyle(color: Colors.grey),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: FadeInUp(
                          duration: const Duration(
                              milliseconds: 1800),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/signup");
                            },
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(
                                  dun),
                            ),
                            child: const Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                ImageIcon(
                                  AssetImage(
                                      "assets/icon/user.png"),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "SignUp",
                                  style: TextStyle(
                                      fontWeight:
                                      FontWeight.bold),
                                ),
                              ],
                            ),
                          )),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: FadeInUp(
                          duration: const Duration(
                              milliseconds: 1900),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(
                                  dun),
                            ),
                            child: const Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                ImageIcon(
                                  AssetImage(
                                      "assets/icon/otp.png"),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Phone N°",
                                  style: TextStyle(
                                      fontWeight:
                                      FontWeight.bold),
                                ),
                              ],
                            ),
                          )),
                    )
                  ],
                ),
                const SizedBox(
                  width: 30,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}


