import 'package:bardu/game.dart';
import 'package:flutter/material.dart';

class PlayersScreen extends StatefulWidget {
  PlayersScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PlayersScreenState createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {

  List<String> _players = [];

  TextEditingController _playerController = new TextEditingController();
  FocusNode _focusNode = FocusNode();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Compte Barbu"),
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
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _players.clear();
                  });
                },
                child: Icon(
                  Icons.delete,
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
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Text(
                'Ajouter des joueurs (min 3, max 5)',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                textInputAction: TextInputAction.done,
                focusNode: _focusNode,
                onSubmitted: (s)  {
                  _addPlayer(s);
                },
                controller: _playerController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Tape le nom du joueur',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: _players.map(
                      (entry) {
                    return GestureDetector(
                      onTap: () {
                        _players.remove(entry);
                        setState(() {

                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(entry),
                      ),
                    );
                  }
                ).toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          if (_players.length < 3) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Pas assez de joueurs')
                )
            );
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GameScreen(players: this._players),
            ),
          );
          // Add your onPressed code here!
        },
        child: Icon(Icons.arrow_right),
      ),
    );
  }

  _addPlayer(String newOne) {
    //String newOne = this._playerController.value.text;
    this._playerController.clear();
    if (_players.length > 5) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Trop de joueurs')
          )
      );
      return;
    }
    if (_players.contains(newOne)) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Ce nom est déjà là')
          )
      );
      return;
    }
    _players.add(newOne);
    _focusNode.requestFocus();
    setState(() {_players;});
  }
}
