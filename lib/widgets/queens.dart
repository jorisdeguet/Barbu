import 'package:barbu/i18n/intl_localization.dart';
import 'package:flutter/material.dart';


class Queens extends StatefulWidget {
  final List<String> players;
  final Function(Map<String,int>) onSave;

  Queens({
    Key key,
    @required this.players,
    @required this.onSave
  }) : super(key: key);

  @override
  _QueensState createState() => _QueensState();
}

class _QueensState extends State<Queens> {

  String loser = null;

  List<String> colors = ["♠", "♥", "♦", "♣"];

  Map<String, List<String>> map = Map();


  @override
  void initState() {
    for(var player in widget.players) {
      map.putIfAbsent(player, () => []);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(Locs.of(context).trans("NO_LADIES")),
          ),),
          Column(
            children: widget.players.map(
                (player) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(player), ),
                      Expanded(
                        flex:4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: colors.map(
                                    (color) => Padding(
                                  padding: const EdgeInsets.fromLTRB(0,5,0,5),
                                  child: Ink(
                                    decoration: ShapeDecoration(
                                      color: isTaken(color, player)? Colors.transparent : Color.fromRGBO(250, 250, 250, 0.9),
                                      shape: CircleBorder(),
                                    ),
                                    child: IconButton(
                                      icon: Text(
                                        color,
                                        style: TextStyle(
                                            color: colorFor(color, isTaken(color, player)),
                                            fontSize: 25,
                                        ),
                                      ),
                                      onPressed: isTaken(color, player) ? null : () {
                                        map[player].add(color);
                                        setState(() {});
                                        answer();
                                      },
                                    ),
                                  ),
                                )
                            ).toList(),
                      )),
                    ],
                  );
                }
            ).toList(),
          ),
        ],
      ),
    );
  }

  isTaken(String color, String player) {
    if (map[player].contains(color)) return false;
    return isTakenC(color);
  }
  isTakenC(String color) {
    for (var entry in this.map.entries) {
      if (entry.value.contains(color)) return true;
    }
    return false;
  }

  answer() {
    for (var color in colors) {
      if (!isTakenC(color)) return;
    }
    Map<String, int> toSend = Map();
    for (var player in widget.players) {
      int score = 0;
      for (var color in colors) {
        if (!this.isTaken(color, player)) score -=10;
      }
      toSend.putIfAbsent(player, () => score);
    }
    widget.onSave(toSend);
  }

  colorFor(String color, bool isTaken) {
    if (isTaken) return Colors.white30;
    if (color == "♠" ) return Colors.black;
    if (color == "♣") return Colors.black;
    return Colors.redAccent;
  }
}
