import 'package:bardu/widgets/count.dart';
import 'package:flutter/material.dart';


class PlisCoeurs extends StatefulWidget {
  final List<String> players;
  final Function(Map<String,int>) onSave;
  final String title;
  final int maxItems;
  final int itemValue;

  PlisCoeurs({
    Key key,
    @required this.title,
    @required this.players,
    @required this.onSave,
    this.maxItems,
    this.itemValue
  }) : super(key: key);

  @override
  _PlisCoeursState createState() => _PlisCoeursState();
}

class _PlisCoeursState extends State<PlisCoeurs> {

  String loser = null;

  Map<String, int> count = Map();

  @override
  void initState() {
    for (String player in widget.players) {
      count.putIfAbsent(player, () => 0);
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
            child: Text(widget.title + " " + currentTotal().toString() + " / " + widget.maxItems.toString()),
          ),),
          Column(
            children: widget.players.map(
                    (player) {
                  return Row(
                    children: [
                      Text(player),
                      Spacer(),
                      Container(
                          child: CounterView(
                            initNumber: count[player],
                            maxNumber: maxForPlayer(player),
                            counterCallback: (val) {
                              print(val.toString() + ' ' + player);
                              setState(() {
                                count[player] = val;
                              });
                              answer();
                            },
                          ),
                      ),
                    ],
                  );
                }
            ).toList(),
          ),
        ],
      ),
    );
  }

  int maxForPlayer(player) {
    return widget.maxItems - currentTotalOther(player);
  }

  int currentTotal() {
    int res = 0 ;
    for (String player in count.keys) {
      res += count[player];
    }
    print("current total " + res.toString());
    return res;
  }

  int currentTotalOther(String p) {
    int res = 0 ;
    for (String player in count.keys) {
      if (player != p) res += count[player];
    }
    print("current total " + res.toString());
    return res;
  }

  void answer() {
    if (currentTotal() == widget.maxItems) {
      Map<String, int> res = Map();
      for (String player in widget.players) {
        res.putIfAbsent(player, () => count[player] * poidsPli() * -1);
      }
      widget.onSave(res);
    }
  }

  int poidsPli() {
    if (widget.players.length == 3) return 4;
    if (widget.players.length == 4) return 5;
    return 7;
  }
}
