import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:quotes/models/author_model.dart';

class AuthorApi {
  static Future<List<AuthorModel>> getResponse(final String base) async {
    var response = await http.get(Uri.parse(base));

    var JsonData = jsonDecode(response.body);
    List<AuthorModel> quotes = [];

    for (var u in JsonData["results"]) {
      AuthorModel model = AuthorModel(
          id: u['_id'], authorName: u['author'], content: u['content']);

      quotes.add(model);
    }

    
    return quotes;
  }
}
