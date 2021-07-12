import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:food_app/model/menu_model.dart';

class MenusViewModel{

  String path = 'assets/menu_files/menu.json';

  readJson() async {
    String main = await rootBundle.loadString(path);
    final decodedJson = await json.decode(main);

    final data = Menu.fromJson(decodedJson);

    return data;
  }
}