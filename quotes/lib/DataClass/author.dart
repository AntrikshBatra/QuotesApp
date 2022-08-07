import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quotes/Api/author_api.dart';
import 'package:quotes/models/author_model.dart';

class AuthorData extends ChangeNotifier {
  List<AuthorModel> author = [];
  bool loading = false;

  String base = 'https://api.quotable.io/search/quotes?query=';
  getDataAuthor(String query, BuildContext context) async {
    loading = true;
    author = await AuthorApi.getResponse(base + query);
    loading = false;

    if (author.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No Quotes found!')));
    }
    notifyListeners();
  }
}
