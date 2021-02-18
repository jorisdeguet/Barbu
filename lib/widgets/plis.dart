import 'package:flutter/material.dart';


class Plis extends StatefulWidget {
  final List<String> players;
  final Function(Map<String,int>) onSave;

  Plis({
    Key key,
    @required this.players,
    @required this.onSave
  }) : super(key: key);

  @override
  _PlisState createState() => _PlisState();
}

class _PlisState extends State<Plis> {

  String loser = null;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Center(child: Text("Plis"),),

      ],
    );
  }
}
