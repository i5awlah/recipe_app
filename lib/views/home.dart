import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/models/recipe_model.dart';
import 'package:recipe_app/views/recipe_view.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Recipe> recipes = [];
  TextEditingController textEditingController = new TextEditingController();
  String applicationId = "5196c3ec";
  String applicationKey = " b2b876c8247894eae3df8e84f977a8d0";

  getRecipes(String query) async {
    recipes.clear();
    var url = Uri.parse(
        "https://api.edamam.com/search?q=$query&app_id=$applicationId&app_key=$applicationKey");
    var response = await http.get(url);
    var recipeResponse = RecipeResponse.fromJson(jsonDecode(response.body));
    for (int i=0; i < recipeResponse.hits.length; i++) {
      recipes.add(recipeResponse.hits[i].recipe);
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              const Color(0xff213A50),
              const Color(0xff071930)
            ])),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: kIsWeb? 24: Platform.isIOS ? 60 : 24, horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: kIsWeb
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    children: [
                      Text(
                        "AppGuy",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'Overpass'),
                      ),
                      Text(
                        "Recipes",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                            fontFamily: 'Overpass'),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "What will you cook today?",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Overpass'),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Just Enter Ingredients you have and we will show the best recipe for you",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'OverpassRegular'),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: textEditingController,
                            decoration: InputDecoration(
                              hintText: "Enter Ingridients",
                              hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white.withOpacity(0.5),
                                  fontFamily: 'Overpass'),
                            ),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: 'Overpass'),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        InkWell(
                            onTap: () {
                              if (textEditingController.text.isNotEmpty) {
                                getRecipes(textEditingController.text);
                                print("just do it");
                              } else {
                                print("just don't do it");
                              }
                            },
                            child: Container(
                                child: Icon(
                              Icons.search,
                              color: Colors.white,
                            ))),
                      ],
                    ),
                  ),
                  GridView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: ClampingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      mainAxisSpacing: 10
                    ),
                    children: List.generate(recipes.length, (index) {
                        return GridTile(child: RecipieTile(
                          title: recipes[index].label,
                          imgUrl: recipes[index].image,
                          desc: recipes[index].source,
                          url: recipes[index].url,
                        ));
                      })
                    ,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RecipieTile extends StatefulWidget {
  final String title, desc, imgUrl, url;

  RecipieTile({required this.title, required this.desc, required this.imgUrl, required this.url});

  @override
  _RecipieTileState createState() => _RecipieTileState();
}

class _RecipieTileState extends State<RecipieTile> {
  _launchURL(String url) async {
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (kIsWeb) {
              _launchURL(widget.url);
            } else {
              print(widget.url + " this is what we are going to see");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecipeView(
                        postUrl: widget.url,
                      )));
            }
          },
          child: Container(
            margin: EdgeInsets.all(8),
            child: Stack(
              children: <Widget>[
                Image.network(
                  widget.imgUrl,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: 200,
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.white30, Colors.white],
                          begin: FractionalOffset.centerRight,
                          end: FractionalOffset.centerLeft)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                              fontFamily: 'Overpass'),
                        ),
                        Text(
                          widget.desc,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.black54,
                              fontFamily: 'OverpassRegular'),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
