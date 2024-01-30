import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Color gold = const Color(0xFFB79347); //buttobs
Color goldAccent = const Color(0xFFDDD3C1);//overlay
Color platinum = const Color(0xFFDEDDDE);
Color dun = const Color(0xFFDBC9A3); //appbar //menu background
Color floral = const Color(0xFFF6F2E8); //background
Color dimGrey = const Color(0xFF6F6F6F);
Color green_ = const Color(0xFF77AF9C);

final appThemeProvider = StateProvider<bool>((ref) => false);

ThemeData getAppTheme(BuildContext context, bool isDarkTheme) {
  return ThemeData(
      useMaterial3: true,
      primaryColor: gold,
      hintColor: dimGrey,


      ///Scaffold
      scaffoldBackgroundColor: floral,

      ///AppBar
      appBarTheme: AppBarTheme(
        color: dun,
        actionsIconTheme: const IconThemeData(
          color: Colors.black
        )
      ),

      ///BottomNavigation
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: dun,
        indicatorColor: gold,

      ),


      ///Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(gold), //button color
          foregroundColor: MaterialStateProperty.all(Colors.white) //text + icon color
        ),

      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: gold,
        foregroundColor: Colors.white
        ),

    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
          //backgroundColor: MaterialStateProperty.all(gold), //button color
          //foregroundColor: MaterialStateProperty.all(Colors.white) //text + icon color
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
         // backgroundColor: MaterialStateProperty.all(gold), //button color
          foregroundColor: MaterialStateProperty.all(Colors.white) //text + icon color
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
          side: MaterialStateProperty.all(BorderSide(color: gold)), //the color of the borders
          overlayColor: MaterialStateProperty.all(goldAccent), //the color when it's clicked
          //backgroundColor: MaterialStateProperty.all(gold), //button color
          foregroundColor: MaterialStateProperty.all(Colors.black) //text + icon color
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(gold), //button color
          foregroundColor: MaterialStateProperty.all(Colors.white) //text + icon color
      ),
    ),

    checkboxTheme: CheckboxThemeData(
      overlayColor: MaterialStateProperty.all(goldAccent),
      checkColor: MaterialStateProperty.all(gold),
      side: BorderSide(color: dimGrey),
      fillColor: MaterialStateProperty.all(platinum)
    ),

    switchTheme: SwitchThemeData(
      overlayColor: MaterialStateProperty.all(goldAccent),
      trackColor: MaterialStateProperty.all(goldAccent),
    ),


    popupMenuTheme: PopupMenuThemeData(
      color: dun,

    ),



    ///List
    listTileTheme: const ListTileThemeData(
      style: ListTileStyle.list
    ),


    ///Dailog
    dialogTheme: DialogTheme(
      backgroundColor: floral,

    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: dun,
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: dun,
      dayPeriodColor: dun,
      dialBackgroundColor: floral,
      hourMinuteColor: floral,
        dialHandColor: gold
    ),

    ///text
    textTheme: const TextTheme(

      labelSmall: TextStyle(color: Colors.black),
      labelMedium:  TextStyle(color: Colors.black),
      labelLarge:  TextStyle(color: Colors.black)
    ),

    ///Change cursor color
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: gold,
    ),


    ///decoration
    inputDecorationTheme: InputDecorationTheme(
      //the label on top of textformfield
      floatingLabelStyle:  TextStyle(color: gold),
      //change the color of the underline in textfield
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
            color: gold
        ),
      ),
      //enabledBorder: InputBorder.none
    ),

    dropdownMenuTheme: DropdownMenuThemeData(
      menuStyle: MenuStyle(
        backgroundColor: MaterialStateProperty.all(floral)
      )
    )
  );
}