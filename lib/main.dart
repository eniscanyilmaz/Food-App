import 'package:flutter/material.dart';

import 'components/globals.dart';
import 'components/widgets.dart';
import 'view/landin_page.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: GlobalContext.appTheme,
      home: LandingPage()
    );
  }
}
