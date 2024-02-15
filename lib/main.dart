import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wedding_planner/firebase_options.dart';
import 'package:wedding_planner/screens/addGuest.dart';
import 'package:wedding_planner/screens/addReminder.dart';
import 'package:wedding_planner/screens/connect/login.dart';
import 'package:wedding_planner/screens/connect/signup.dart';
import 'package:wedding_planner/screens/pages/homeScreen.dart';
import 'package:wedding_planner/style/Theme.dart';




Future main() async{


  ///firebase initialisation
  WidgetsFlutterBinding.ensureInitialized();
  try {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
      runApp(const ProviderScope(child:  MyApp())); //to be able to change theme
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'error initializing firebase app $e',
      );
  }

}

//to be able to use pushNamed
Map<String, WidgetBuilder> routes = {
  "/": (context) => const HomeScreen(),
  "/addReminder": (context) => const AddReminder(),
  "/addGuest" : (context)=> const AddGuest(),
  "/login" : (context)=> const Login(),
  "/signup" : (context)=> const SignupPage(),
};

class MyApp extends StatelessWidget {
  const MyApp({super.key});





  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wedding planner',
      theme: myTheme,
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: '/login',

    );
  }
}
