import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes/DataClass/category_data.dart';
import 'package:quotes/DataClass/fav.dart';
import 'package:quotes/Screens/author_screen.dart';
import 'package:quotes/Screens/category_screen.dart';
import 'package:quotes/Screens/fav_screen.dart';
import 'package:quotes/models/author_model.dart';

import 'DataClass/author.dart';
import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthorData>(create: (_) => AuthorData()),
      ChangeNotifierProvider<CategoryData>(create: (_) => CategoryData()),
      ChangeNotifierProvider<FavQuotes>(create: (_) => FavQuotes())
    ],
    child: const MyApp(),
  ));
}

class _HomePageState extends State<HomePage> {
  Future<List<AuthorModel>>? model;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // final favss = Provider.of<FavQuotes>(context);
    // FavQuotes.fav = favss.readSharePref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 24, 82, 129),
        centerTitle: true,
        title: const Text(
          'Quotes App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => const AuthorScreen(),
                        transitionsBuilder: (c, anim, a2, child) =>
                            FadeTransition(
                              opacity: anim,
                              child: child,
                            ),
                        transitionDuration: const Duration(milliseconds: 250)));
              },
              child: Container(
                height: 160,
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.yellow, Colors.blue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: const Center(
                  child: Text(
                    'Author Quote',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => const CategoryScreen(),
                        transitionsBuilder: (c, anim, a2, child) =>
                            FadeTransition(
                              opacity: anim,
                              child: child,
                            ),
                        transitionDuration: const Duration(milliseconds: 250)));
              },
              child: Container(
                height: 160,
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.green, Colors.blue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: const Center(
                  child: Text(
                    'Search Quote',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (c, a1, a2) => const FavScreen(),
                        transitionsBuilder: (c, anim, a2, child) =>
                            FadeTransition(
                              opacity: anim,
                              child: child,
                            ),
                        transitionDuration: const Duration(milliseconds: 250)));
              },
              child: Container(
                height: 160,
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.orange, Colors.blue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: const Center(
                  child: Text(
                    'Favoriate Quotes',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
