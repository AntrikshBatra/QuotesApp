import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes/DataClass/category_data.dart';
import 'package:quotes/DataClass/fav.dart';

import '../models/author_model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController _categoryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<CategoryData>(context);
    final favss = Provider.of<FavQuotes>(context);
    if (FavQuotes.fav.isEmpty) {
      favss.readSharePref();
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 24, 82, 129),
          title: const Text('Category Screen'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(9),
                child: TextField(
                  controller: _categoryController,
                  decoration: InputDecoration(
                    hintText: "Enter Category",
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
                  Provider.of<CategoryData>(context, listen: false)
                      .getDataAuthor(_categoryController.text, context);
                },
                child: Container(
                  width: 90,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.red, Colors.blue],
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
                  categories.isLoading
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
                                                Colors.pink,
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
                                                  " ${categories.category[index].content} ",
                                                  textAlign: TextAlign.center,
                                                  maxLines: 4,
                                                  style: TextStyle(
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
                                                      '-${categories.category[index].authorName}',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              
                                              !FavQuotes.fav.contains(
                                                      AuthorModel(
                                                          id: categories
                                                              .category[index]
                                                              .id,
                                                          authorName: categories
                                                              .category[index]
                                                              .authorName,
                                                          content: categories
                                                              .category[index]
                                                              .content))
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            favss.storeToSharedPref(
                                                                categories
                                                                        .category[
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
                                  itemCount: categories.category.length,
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
