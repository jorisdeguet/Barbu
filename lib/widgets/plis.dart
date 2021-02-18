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
                            initNumber: 0,
                            counterCallback: (val) {
                              print(val.toString() + ' ' + player);
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

  List<int> range(List<String> players)  {
    if (players.length == 5) return [1,2,3,4,5];
    if (players.length == 4) return [1,2,3,4,5,6,7,8];
    return [1,2,3,4,5,6,7,8,9,10];
  }
}
