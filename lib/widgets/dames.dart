import 'package:flutter/material.dart';


class Dames extends StatefulWidget {
  final List<String> players;
  final Function(Map<String,int>) onSave;

  Dames({
    Key key,
    @required this.players,
    @required this.onSave
  }) : super(key: key);

  @override
  _DamesState createState() => _DamesState();
}

class _DamesState extends State<Dames> {

  String loser = null;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Center(child: Text("Dames"),),

      ],
    );
  }
}
