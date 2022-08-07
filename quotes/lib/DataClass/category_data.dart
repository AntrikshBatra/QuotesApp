import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quotes/Api/author_api.dart';
import 'package:quotes/models/author_model.dart';

class CategoryData extends ChangeNotifier {
  List<AuthorModel> category = [];
  bool isLoading = false;

  String base = 'https://api.quotable.io/search/quotes?query=';
  getDataAuthor(String query, BuildContext context) async {
    isLoading = true;
    category = await AuthorApi.getResponse(base + query);
    isLoading = false;

    if (category.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No Quotes found!')));
    }
    notifyListeners();
  }
}
