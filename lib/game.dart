import 'package:bardu/widgets/coeurs.dart';
import 'package:bardu/widgets/dames.dart';
import 'package:bardu/widgets/domino.dart';
import 'package:bardu/widgets/plis.dart';
import 'package:flutter/material.dart';
import 'package:sortedmap/sortedmap.dart';

import 'widgets/barbu.dart';

class GameScreen extends StatefulWidget {
  GameScreen({Key key, this.players}) : super(key: key);

  final List<String> players;

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  SortedMap<String, int> _players = SortedMap(Ordering.byValue());

  Map<String, int> delta = null;

  List<String> _types = ['Pas de pli', 'Pas de coeur', 'Pas de dames', 'Barbu', 'Domino'];
  String _type = null;
  
  @override
  void initState() {
    for(String p in widget.players) {
      _players.putIfAbsent(p, () => 0);
    }
    print(_players);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Partie"),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {

                },
                child: Icon(
                  Icons.settings,
                  size: 26.0,
                ),
              )
          ),
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  print('Card tapped.');
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                      width: double.infinity,
                      child: Column(
                        children: _players.entries.map(
                                (entry) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(children: [
                                  Text(entry.key),
                                  Spacer(),
                                  Text(entry.value.toString()),
                                ],),
                              );
                            }
                        ).toList(),
                      )
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 25,
            ),

            AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                child: _type == null ? selecteur():
                _widget(),
            ),
          ],
        ),
      ),
    );
  }

  _widget() {
    Widget w = Text('TODO');
    if (_type == 'Domino')
      w = Domino(players: widget.players,onSave: _update);
    if (_type == 'Barbu')
      w = Barbu(players: widget.players,onSave: _update);
    if (_type == 'Pas de pli')
      w = Plis(players: widget.players,onSave: _update);
    if (_type == 'Pas de dames')
      w = Dames(players: widget.players,onSave: _update);
    if (_type == 'Pas de coeur')
      w = Coeurs(players: widget.players,onSave: _update);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
            primary: Colors.red, // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () {
              this._type = null;
              setState(() {});
            },
            child: Text('Annule')
            ),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // background
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: delta == null ? null : () {
                  this._confirmUpdate();
                },
                icon: Icon(Icons.arrow_upward_outlined),
                label: Text('Sauve')
            ),
          ],
        ),
        SizedBox(height: 25,),
        Card(
          color: Colors.black87,
          child: w,
        ),
      ],
    );

  }

  _confirmUpdate() {
    for (var entry in delta.entries) {
      this._players[entry.key] += entry.value;
    }
    this.delta = null;
    this._type = null;
    setState(() {});
  }

  _update(Map<String, int> delta) {
    print('TODO ' + delta.toString());
    setState(() {
      this.delta = delta;
    });
  }

  selecteur() {
    return Wrap(
        children: _types.map(
                (type) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _type = type;
                    });
                  },
                  child: Text(type),
                ),
              );
            }
        ).toList()
    );
  }
}
