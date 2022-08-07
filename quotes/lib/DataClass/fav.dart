import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:quotes/models/author_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavQuotes extends ChangeNotifier {
  static List<AuthorModel> fav = [];

  storeToSharedPref(AuthorModel model) async {
    fav.add(model);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('local', json.encode(fav));
    print(fav.length);
    notifyListeners();
  }

  deleteFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('local', json.encode(fav));
    fav;
    notifyListeners();
  }

  readSharePref() async {
    final prefs = await SharedPreferences.getInstance();
    fav = json.decode(prefs.getString('local')!);
    notifyListeners();
  }
}
