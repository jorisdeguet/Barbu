import 'package:bardu/players.dart';
import 'package:flutter/material.dart';

// TODO https://www.youtube.com/watch?v=futE-2pAE30

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barbu',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: PlayersScreen(title: 'Flutter Demo Home Page'),
    );
  }
}

