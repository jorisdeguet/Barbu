import 'package:flutter/material.dart';


class Domino extends StatefulWidget {
  final List<String> players;
  final Function(Map<String,int>) onSave;

  Domino({
    Key key,
    @required this.players,
    @required this.onSave
  }) : super(key: key);

  @override
  _DominoState createState() => _DominoState();
}

class _DominoState extends State<Domino> {

  String player100 = '';
  String player60 = '';

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Row(
          children: [
            Text(' + 100 :'),
            this.player100 != '' ?
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(this.player100),
            ) :
            Wrap(
              children: widget.players
                  .where((elt) => elt != player60)
                  .map(
                      (player) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            this.player100 = player;
                          });
                          answer();
                        },
                        child: Text(player),
                      ),
                    );
                  }
              ).toList(),
            )
          ],
        ),
        Row(
          children: [
            Text(' + 60 :'),
            this.player60 != '' ?
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(this.player60),
            ) :
            Wrap(
              children: widget.players
                  .where((elt) => elt != player100)
                  .map(
                      (player) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            this.player60 = player;
                          });
                          answer();
                        },
                        child: Text(player),
                      ),
                    );
                  }
              ).toList(),
            )
          ],
        ),
      ],
    );
  }

  void answer() {
    if (this.player100 != '' && this.player60 != '') {
      Map<String, int> map = Map();
      map.putIfAbsent(player100, () => 100);
      map.putIfAbsent(player60, () => 60);
      widget.onSave(map);
    }
  }
}
