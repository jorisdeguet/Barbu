import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  GameScreen({Key key, this.players}) : super(key: key);

  final List<String> players;

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  Map<String, int> _players = Map();

  TextEditingController _playerController = new TextEditingController();


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
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
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
              children: _players.entries.map(
                      (entry) {
                    return GestureDetector(
                      onTap: () {
                        _players.remove(entry);
                        setState(() {

                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(entry.key),
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
}
