import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedding_planner/screens/addGuest.dart';
import 'package:wedding_planner/screens/addReminder.dart';
import 'package:wedding_planner/screens/homeScreen.dart';
import 'package:wedding_planner/screens/login.dart';
import 'package:wedding_planner/style/Theme.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try {
      await Firebase.initializeApp();
      runApp(const ProviderScope(child:  MyApp())); //to be able to change theme
    } catch (e) {
      print('error initializing firebase app $e');
  }
}

//to be able to use pushNamed
Map<String, WidgetBuilder> routes = {
  "/": (context) => const HomeScreen(),
  "/addReminder": (context) => const AddReminder(),
  "/addGuest" : (context)=> const AddGuest(),
  "/login" : (context)=> const Login(),
};

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final appThemeProvider = StateProvider<bool>((ref) => false);
    return MaterialApp(
      title: 'Wedding planner',
      theme: getAppTheme(context, ref.watch(appThemeProvider)),
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: "/login",
    );
  }
}
