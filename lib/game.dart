import 'package:bardu/widgets/coeurs.dart';
import 'package:bardu/widgets/dames.dart';
import 'package:bardu/widgets/domino.dart';
import 'package:bardu/widgets/plis.dart';
import 'package:flutter/material.dart';

import 'widgets/barbu.dart';

class GameScreen extends StatefulWidget {
  GameScreen({Key key, this.players}) : super(key: key);

  final List<String> players;

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  List<GamePart> history = [];
  Map<String, int> delta = null;

  List<String> _types = ['Pas de pli', 'Pas de coeur', 'Pas de dames', 'Barbu', 'Domino'];
  String _type = null;

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
                history.clear();
                setState(() {});
              },
              child: Icon(
                Icons.delete,
                size: 26.0,
              ),
            )
          ),
        ],
      ),
      body: SingleChildScrollView(
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
                        children: consolidated().entries.map(
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
            SizedBox(height: 25,),
            Column(
              children: history.map(
                      (elt) {
                    return Card(
                      child: ListTile(
                        title: Text(elt.type),
                        subtitle: Text(toString(elt.scores)),
                        trailing: Icon(Icons.delete),
                      ),
                    );
                  }

              ).toList(),
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
    if (_type == 'Pas de dames')
      w = Dames(players: widget.players,onSave: _update);
    if (_type == 'Pas de coeur')
      w = PlisCoeurs(title: 'Coeurs', maxItems: 8, itemValue: 5,
          players: widget.players,onSave: _update);
    if (_type == 'Pas de pli')
      w = PlisCoeurs(title: 'Plis',
          maxItems: widget.players.length == 3 ? 10 :
            widget.players.length == 4 ? 8 : 6,
          itemValue: widget.players.length == 3 ? 4 :
          widget.players.length == 4 ? 5 : 7,
          players: widget.players,onSave: _update);
    return Center(
      child: Column(
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
          SizedBox(height: 20,),
          Card(
            color: Colors.black87,
            child: w,
          ),
        ],
      ),
    );

  }

  Map<String, int> consolidated() {
    Map<String, int> res = Map();
    for(String p in widget.players) {
      res.putIfAbsent(p, () => 0);
    }
    for(GamePart part in history) {
      for(String p in widget.players) {
        if (part.scores.containsKey(p)) {
          res[p] += part.scores[p];
        }
      }
    }
    return res;
  }

  _confirmUpdate() {
    GamePart forHistory = GamePart();
    forHistory.scores = delta;
    forHistory.type = _type;
    this.history.insert(0, forHistory);
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

class GamePart {
  Map<String, int> scores;
  String type;
}
