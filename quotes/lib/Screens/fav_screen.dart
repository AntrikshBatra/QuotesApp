import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes/DataClass/fav.dart';
import 'package:quotes/models/author_model.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   final favss = Provider.of<FavQuotes>(context);
   if (FavQuotes.fav.isEmpty) {
      favss.readSharePref();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fav Quotes'),
        centerTitle: false,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: 600,
                child: ListView.builder(
                    itemCount: FavQuotes.fav.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: Container(
                          width: double.infinity,
                          height: 180,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.orange, Colors.black]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7))),
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Text(
                                " ${FavQuotes.fav[index].content} ",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, bottom: 7),
                                  child: Text(
                                    '-${FavQuotes.fav[index].authorName}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    FavQuotes.fav.removeAt(index);
                                    favss.deleteFromSharedPref();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text('Removed from Fav'),
                                      
                                    ));
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    size: 25,
                                  ),
                                )
                              ],
                            )
                          ]),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
