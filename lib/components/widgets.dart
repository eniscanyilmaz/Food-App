import 'package:flutter/material.dart';

class GlobalContext {
  static final appTheme = ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Raleway2'
      );
}

class ColorPallette {
  static final color1 = Color(0xff202020);
  static final color2 = Colors.amber;
  static final color3 = Colors.red[600];
}

class TextThemeData {
  static final subTitleTextStyleW = TextStyle(color: Colors.white, fontSize: 18);
  static final titleTextStyleW = TextStyle(color: Colors.white, fontFamily: 'Raleway', fontSize: 24);
  static final subTitleTextStyleD = TextStyle(color: Colors.black, fontSize: 18);
  static final titleTextStyleD = TextStyle(color: Colors.black, fontFamily: 'Raleway', fontSize: 24);
}
