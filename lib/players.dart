import 'package:barbu/game.dart';
import 'package:barbu/i18n/intl_localization.dart';
import 'package:flutter/material.dart';

class PlayersScreen extends StatefulWidget {
  PlayersScreen({Key key}) : super(key: key);

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
        title: Text(Locs.of(context).trans("APP_TITLE")),
        actions: <Widget>[
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
      body: SingleChildScrollView(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(28.0,30,28,10),
              child: Text(
                Locs.of(context).trans("ADD_PLAYERS"),
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex:1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      textInputAction: TextInputAction.done,
                      focusNode: _focusNode,
                      onSubmitted: (s)  {
                        _addPlayer(s);
                      },
                      controller: _playerController,

                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Text("+"),
                          color: Colors.blue,
                          onPressed: () {
                            _addPlayer(_playerController.value.text);
                          },
                        ),
                        border: const OutlineInputBorder(),
                        hintText: Locs.of(context).trans("TYPE_PLAYER_NAME"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Wrap(
              children: _players.map(
                      (entry) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ElevatedButton.icon(
                          onPressed: () {
                            _players.remove(entry);
                            setState(() {});
                          },
                          icon: Icon(Icons.delete),
                          label: Text(entry)
                      ),
                    );
                  }
                ).toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: _players.length < 3 ?
      Container() :
      FloatingActionButton(
        onPressed: () {
          if (_players.length != 4) {
            _show2CardsDialog();
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GameScreen(players: this._players),
              ),
            );
          }
          // Add your onPressed code here!
        },
        child: SizedBox(
          height: 45,
          child: Image.asset('assets/barbu.png'),
        ),
      ),
    );
  }

  _addPlayer(String newOne) {
    //String newOne = this._playerController.value.text;
    this._playerController.clear();
    if (newOne.trim().length == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(Locs.of(context).trans("ERROR_EMPTY"))
          )
      );
      return;
    }
    if (newOne.trim().length > 50) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(Locs.of(context).trans("ERROR_TOO_LONG"))
          )
      );
      return;
    }
    if (_players.length > 4) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(Locs.of(context).trans("ERROR_TOO_MANY"))
          )
      );
      return;
    }
    if (_players.contains(newOne.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(Locs.of(context).trans("ERROR_EXISTING"))
          )
      );
      return;
    }
    _players.add(newOne.trim());
    _focusNode.requestFocus();
    setState(() {_players;});
  }

  Future<void> _show2CardsDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Locs.of(context).trans("DIALOG_ALERT")),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(Locs.of(context).trans("DIALOG_2CARDS")),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameScreen(players: this._players),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

}
