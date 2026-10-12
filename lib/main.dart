import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moaather/Utils/ThemeUtils.dart';
import 'package:moaather/src/SearchFieldWidget.dart';
import 'package:moaather/src/shared/widgets/instagram_post_preview.dart';
import 'package:moaather/src/shared/widgets/social_media_post.dart';
import 'package:moaather/src/shared/widgets/x_post_preview.dart';
import 'package:moaather/src/sidebar/sidebar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ThemeUtils.darkTheme),
      home: const MyHomePage(title: 'Moaather'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(flex: 1, child: SideBarWidget()),
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: .spaceBetween,
              children: [
                Expanded(child: Container()),
                Expanded(
                  flex: 5,
                  child: Row(
                    mainAxisAlignment: .spaceAround,
                    crossAxisAlignment: .center,

                    children: [
                      FacebookPostPreview(
                        name: "Samir Ahmad",
                        text: """
lorem ipsdfsdf sdfsodf sdoifs dfosidfs dfj sdf sadFoae ضصخجثهبقةضشخصيب شاتيبشجخصيس شنتصسي 
lorem ipsdfsdf sdfsodf sdoifs dfosidfs dfj sdf sadFoae ضصخجثهبقةضشخصيب شاتيبشجخصيس شنتصسي 
lorem ipsdfsdf sdfsodf sdoifs dfosidfs dfj sdf sadFoae ضصخجثهبقةضشخصيب شاتيبشجخصيس شنتصسي 
                            
                            """,
                        verified: false,
                        timeLabel: "1 min",
                        leftImage: AssetImage("images/left.jpeg"),
                        rightImage: AssetImage("images/right.jpg"),
                      ),
                      InstagramPostPreview(
                        likesCount: 100,
                        caption: "lorem ipsum ad d qwddeed",
                        leftImage: AssetImage("images/left.jpeg"),
                        rightImage: AssetImage("images/right.jpg"),
                        timeLabel: "now",
                        username: "Samir Ahmad",
                        verified: false,
                        avatarImage: AssetImage("images/right.jpg"),
                      ),
                      XPostPreview(
                        text: "lorem ipsum ad d qwddeed",
                        handle: "",
                        leftImage: AssetImage("images/left.jpeg"),
                        rightImage: AssetImage("images/right.jpg"),
                        timeLabel: "now",
                        displayName: "Samir Ahmad",
                        verified: false,
                        avatarImage: AssetImage("images/right.jpg"),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    crossAxisAlignment: .end,
                    children: [
                      Expanded(
                        child: ChatTextField(
                          onSend: (text) {},
                          enterToSend: true,
                          hintText: "Describe what you like to Create",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
