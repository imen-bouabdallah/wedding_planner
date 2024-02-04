import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:wedding_planner/screens/homeScreen.dart';
import 'package:wedding_planner/style/Theme.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 250,
                child: FadeInUp(duration: Duration(milliseconds: 1600), child: Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Center(
                    child: Text("Login", style: TextStyle(color: gold, fontSize: 40, fontWeight: FontWeight.bold),),
                  ),
                )),
              ),
              const SizedBox(height:100, child: Image(image: AssetImage('assets/images/wedding.png'),)),
              const SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    FadeInUp(duration: Duration(milliseconds: 1800), child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: gold),
                          boxShadow: [
                           BoxShadow(
                                color: goldAccent,
                                blurRadius: 20.0,
                                offset: Offset(0, 10)
                            )
                          ]
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: gold))
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email or Phone number",
                                  hintStyle: TextStyle(color: Colors.grey[700])
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey[700])
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
                    const SizedBox(height: 30,),
                    FadeInUp(duration: const Duration(milliseconds: 1900), child: DecoratedBox(
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
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const HomeScreen()),
                          );
                        },
                        child: const Center(
                          child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                      ),
                    )),
                    const SizedBox(height: 10,),
                    FadeInUp(duration: Duration(milliseconds: 2000),
                        child: TextButton(
                          onPressed: (){},
                          child: Text("Forgot Password?", style: TextStyle(color: gold),),
                     )),
                    const SizedBox(height: 20,),
                    FadeInUp(duration: Duration(milliseconds: 1700), child: Text("Continue with social media", style: TextStyle(color: Colors.grey),)),
                    const SizedBox(height: 10,),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: FadeInUp(duration: Duration(milliseconds: 1800), child: ElevatedButton(
                            onPressed: (){},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                              foregroundColor: null,
                              iconColor: null,
                            ),

                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ImageIcon(AssetImage("assets/icon/google.png"), color: Colors.black,),
                                SizedBox(width: 10,),
                                Text("Gmail", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                              ],
                            ),
                          )),
                        ),
                        const SizedBox(width: 30,),
                        Expanded(
                          child: FadeInUp(duration: const Duration(milliseconds: 1900), child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                              iconColor: null,
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ImageIcon(AssetImage("assets/icon/otp.png"), color: Colors.black,),
                                SizedBox(width: 5,),
                                Text("Phone N°", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
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
    );
  }
}
