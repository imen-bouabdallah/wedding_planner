import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedding_planner/screens/addGuest.dart';
import 'package:wedding_planner/screens/addReminder.dart';
import 'package:wedding_planner/screens/homeScreen.dart';
import 'package:wedding_planner/screens/splash_screen.dart';
import 'package:wedding_planner/style/Theme.dart';

void main() {
  runApp(const ProviderScope(child:  MyApp())); //to be able to change theme
}

//to be able to use pushNamed
Map<String, WidgetBuilder> routes = {
  "/home": (context) => const HomeScreen(),
  "/addReminder": (context) => const AddReminder(),
  "/addGuest" : (context)=> const AddGuest(),
  "/splash" : (context)=> const SplashScreen(),
};

class MyApp extends ConsumerWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final appThemeProvider = StateProvider<bool>((ref) => false);
    return MaterialApp(
      title: 'Wedding planner',
      theme: getAppTheme(context, ref.watch(appThemeProvider)),

      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: "/splash",
    );
  }
}
