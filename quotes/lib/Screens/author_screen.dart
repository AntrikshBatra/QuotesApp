import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes/DataClass/author.dart';
import 'package:quotes/DataClass/fav.dart';
import 'package:quotes/models/author_model.dart';

class AuthorScreen extends StatefulWidget {
  const AuthorScreen({Key? key}) : super(key: key);

  @override
  State<AuthorScreen> createState() => _AuthorScreenState();
}

class _AuthorScreenState extends State<AuthorScreen> {
  final TextEditingController _authorController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // final authors = Provider.of<AuthorData>(context, listen: false);
    // authors.getDataAuthor();
    
  }

  @override
  Widget build(BuildContext context) {
    final authors = Provider.of<AuthorData>(context);
    final favs = Provider.of<FavQuotes>(context);
    
    if (FavQuotes.fav.isEmpty) {
      favs.readSharePref();
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 24, 82, 129),
          title: const Text('Author Screen'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(9),
                child: TextField(
                  controller: _authorController,
                  decoration: InputDecoration(
                    hintText: "Enter Author Name",
                    border: OutlineInputBorder(
                        borderSide: Divider.createBorderSide(context)),
                    iconColor: Colors.grey,
                    focusColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide: Divider.createBorderSide(context)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: Divider.createBorderSide(context)),
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                  ),
                  keyboardType: TextInputType.name,
                  obscureText: false,
                ),
              )),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Provider.of<AuthorData>(context, listen: false)
                      .getDataAuthor(_authorController.text, context);
                },
                child: Container(
                  width: 90,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green, Colors.red],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: const Text(
                    'Search',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              Column(
                children: [
                  authors.loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Expanded(
                            child: SingleChildScrollView(
                              child: SizedBox(
                                width: double.infinity,
                                height: 500,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: EdgeInsets.all(7),
                                      child: Container(
                                          width: double.infinity,
                                          height: 180,
                                          decoration: const BoxDecoration(
                                              gradient: LinearGradient(colors: [
                                                Colors.green,
                                                Colors.black
                                              ]),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8))),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 6),
                                                child: Text(
                                                  " ${authors.author[index].content} ",
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8,
                                                            bottom: 7),
                                                    child: Text(
                                                      '-${authors.author[index].authorName}',
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              !FavQuotes.fav.contains(
                                                      AuthorModel(
                                                          id: authors
                                                              .author[index].id,
                                                          authorName: authors
                                                              .author[index]
                                                              .authorName,
                                                          content: authors
                                                              .author[index]
                                                              .content))
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            favs.storeToSharedPref(
                                                                authors.author[
                                                                    index]);
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    const SnackBar(
                                                              content: Text(
                                                                  'Added To Fav'),
                                                            ));
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .star_border_outlined,
                                                            size: 25,
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  : const SizedBox()
                                            ],
                                          )),
                                    );
                                  },
                                  itemCount: authors.author.length,
                                ),
                              ),
                            ),
                          ),
                        )
                ],
              )
            ],
          ),
        ));
  }
}
