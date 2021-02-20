import 'package:barbu/i18n/intl_localization.dart';
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
                    children: [
                      Expanded(child: Text(player), flex: 1,),
                      Expanded(
                        flex:4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: colors.map(
                                    (color) => Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Ink(
                                    decoration: ShapeDecoration(
                                      color: isTaken(color, player)? Colors.transparent : Colors.indigo,
                                      shape: CircleBorder(),
                                    ),
                                    child: IconButton(
                                      icon: Text(color),
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
}
