import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes/DataClass/author.dart';
import 'package:quotes/DataClass/category_data.dart';
import 'package:quotes/DataClass/fav.dart';
import 'package:quotes/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthorData>(create: (context) => AuthorData()),
        ChangeNotifierProvider<CategoryData>(
            create: (context) => CategoryData()),
        ChangeNotifierProvider<FavQuotes>(create: (context) => FavQuotes())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quotes App',
        home: const HomePage(),
      ),
    );
  }
}
