import 'package:bardu/widgets/count.dart';
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

  int maxTotal = 8;

  Map<String, int> count = Map();

  @override
  void initState() {
    if (widget.players.length == 3) maxTotal = 10;
    if (widget.players.length == 5) maxTotal = 6;
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
            child: Text("Plis"),
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

  int maxForPlayer(playser) {
    return this.maxTotal - currentTotal();
  }

  int currentTotal() {
    int res = 0 ;
    for (String player in count.keys) {
      res += count[player];
    }
    print("current total " + res.toString());
    return res;
  }
}
