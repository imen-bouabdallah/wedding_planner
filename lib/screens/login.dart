import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wedding_planner/classes/Functions.dart';
import 'package:wedding_planner/screens/homeScreen.dart';
import 'package:wedding_planner/style/Theme.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {


  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signInWithNumber() async {
    /*await FirebaseAuth.instance.signInWithPhoneNumber(

      );*/
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) =>
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 250,
                        child: FadeInUp(
                            duration: const Duration(milliseconds: 1600),
                            child: Container(
                              margin: const EdgeInsets.only(top: 50),
                              child: Center(
                                child: Text("Login", style: TextStyle(
                                    color: gold,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),),
                              ),
                            )),
                      ),
                      const SizedBox(height: 100,
                          child: Image(
                            image: AssetImage('assets/images/wedding.png'),)),
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          children: <Widget>[
                            FadeInUp(
                                duration: const Duration(milliseconds: 1800),
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: gold),
                                      boxShadow: [
                                        BoxShadow(
                                            color: goldAccent,
                                            blurRadius: 20.0,
                                            offset: const Offset(0, 10)
                                        )
                                      ]
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(color: gold))
                                        ),
                                        child: TextField(
                                          controller: _emailController,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Email",
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[700])
                                          ),
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
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[700])
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                            const SizedBox(height: 30,),
                            FadeInUp(
                                duration: const Duration(milliseconds: 1900),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(
                                          colors: [
                                            dun,
                                            goldAccent
                                          ]
                                      )
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      if(_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty)
                                        SignIn(_emailController.text, _passwordController.text, context);
                                    },
                                    child: const Center(
                                      child: Text("Login", style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),),
                                    ),
                                  ),
                                )),
                            const SizedBox(height: 10,),
                            FadeInUp(
                                duration: const Duration(milliseconds: 2000),
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Forgot Password?", style: TextStyle(
                                      color: gold),),
                                )),
                            const SizedBox(height: 20,),
                            FadeInUp(
                                duration: const Duration(milliseconds: 1700),
                                child: const Text("Continue with social media",
                                  style: TextStyle(color: Colors.grey),)),
                            const SizedBox(height: 10,),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: FadeInUp(duration: const Duration(
                                      milliseconds: 1800),
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty
                                              .all(Colors.white),
                                          foregroundColor: null,
                                          iconColor: null,
                                        ),

                                        child: const Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: [
                                            ImageIcon(AssetImage(
                                                "assets/icon/google.png"),
                                              color: Colors.black,),
                                            SizedBox(width: 10,),
                                            Text("Gmail", style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                      )),
                                ),
                                const SizedBox(width: 30,),
                                Expanded(
                                  child: FadeInUp(duration: const Duration(
                                      milliseconds: 1900),
                                      child: ElevatedButton(
                                        onPressed: () {

                                        },
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty
                                              .all(Colors.white),
                                          iconColor: null,
                                        ),
                                        child: const Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: [
                                            ImageIcon(
                                              AssetImage("assets/icon/otp.png"),
                                              color: Colors.black,),
                                            SizedBox(width: 5,),
                                            Text("Phone N°", style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                      )),
                                )
                              ],
                            ),
                            const SizedBox(width: 30,)
                          ],
                        ),
                      )
                    ],
                  ),
                )
        )

    );
  }
}
