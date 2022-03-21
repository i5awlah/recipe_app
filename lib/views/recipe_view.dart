import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:webview_flutter/webview_flutter.dart';

class RecipeView extends StatefulWidget {
  final String postUrl;
  RecipeView({Key? key, required this.postUrl}) : super(key: key);

  @override
  _RecipeViewState createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  late String finalUrl;
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    if (widget.postUrl.contains("http://")) {
      finalUrl = widget.postUrl.replaceAll("http://", "https://");
    } else {
      finalUrl = widget.postUrl;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: Platform.isIOS ? 60 : 30,
                    right: 24,
                    left: 24,
                    bottom: 16),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  const Color(0xff213A50),
                  const Color(0xff071930)
                ])),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment:
                      kIsWeb ? MainAxisAlignment.start : MainAxisAlignment.center,
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
              ),
              Container(
                height: MediaQuery.of(context).size.height - 200,
                width: MediaQuery.of(context).size.width,
                child: WebView(
                  initialUrl: finalUrl,
                  onWebViewCreated: (WebViewController webViewController) {
                    setState(() {
                      _controller.complete(webViewController);
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
