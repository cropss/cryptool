// app.dart

import 'package:cryptool/screens/encrpt/encrypt.dart';
import 'package:cryptool/screens/home/home.dart';
import 'package:flutter/material.dart';

import 'screens/decrypt/decrypt.dart';

const HomeRoute = '/';
const EncryptRoute = '/encrypt';
const DecryptRoute = '/decrypt';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: _routes(),
    );
  }

  RouteFactory _routes() {
    return (settings) {
      final Map<String, dynamic> arguments = settings.arguments;
      Widget screen;
      switch (settings.name) {
        case HomeRoute:
          screen = Home();
          break;
        case EncryptRoute:
          screen = EncryptionScreen();
          break;
        case DecryptRoute:
          screen = DecryptionScreen();
          break;
        default:
          return null;
      }
      return MaterialPageRoute(builder: (BuildContext context) => screen);
    };
  }

  // ThemeData _theme() {
  //   return ThemeData(
  //       appBarTheme:
  //           AppBarTheme(textTheme: TextTheme(headline1: AppBarTextStyle)),
  //       textTheme: TextTheme(
  //         headline1: TitleTextStyle,
  //         bodyText1: BodyTextStyle,
  //       ));
  // }
}