import 'package:flutter/material.dart';


class Coeurs extends StatefulWidget {
  final List<String> players;
  final Function(Map<String,int>) onSave;

  Coeurs({
    Key key,
    @required this.players,
    @required this.onSave
  }) : super(key: key);

  @override
  _CoeursState createState() => _CoeursState();
}

class _CoeursState extends State<Coeurs> {

  String loser = null;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.all(10.0),
      child: loser != null ?
      Text(loser) :
      Wrap(
        children: widget.players.map(
                (player) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      loser = player;
                      Map<String, int> map = Map();
                      map.putIfAbsent(player, () => -40);
                      widget.onSave(map);
                      setState(() {});
                    },
                    child: Text(player)
                ),
              );
            }
        ).toList(),
      ),
    );
  }
}
