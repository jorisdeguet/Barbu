import 'package:barbu/i18n/intl_localization.dart';
import 'package:flutter/material.dart';


class Barbu extends StatefulWidget {
  final List<String> players;
  final Function(Map<String,int>) onSave;

  Barbu({
    Key key,
    @required this.players,
    @required this.onSave
  }) : super(key: key);

  @override
  _BarbuState createState() => _BarbuState();
}

class _BarbuState extends State<Barbu> {

  String loser = null;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(Locs.of(context).trans('BARBU')),
          ),
        ),
        Padding(
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
        )
      ],
    );
  }
}
