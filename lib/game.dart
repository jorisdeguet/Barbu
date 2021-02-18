import 'package:flutter/material.dart';
import 'package:sortedmap/sortedmap.dart';

class GameScreen extends StatefulWidget {
  GameScreen({Key key, this.players}) : super(key: key);

  final List<String> players;

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  SortedMap<String, int> _players = SortedMap(Ordering.byValue());

  bool _biggy = false;

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
            GestureDetector(
              onTap: () {
                setState(() {
                  _biggy = !_biggy;
                  _type = null;
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 1234),
                color: Colors.blue,
                width: _biggy ? 10 : 300,
                height: 30,
              ),
            ),

            SizedBox(
              height: 10,
            ),
            AnimatedOpacity(
              // If the widget is visible, animate to 0.0 (invisible).
              // If the widget is hidden, animate to 1.0 (fully visible).
              opacity: _type == null ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              // The green box must be a child of the AnimatedOpacity widget.
              child: Container(

                color: Colors.red,
                child: Wrap(
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
                  ).toList(),
                ),
              ),
            ),


            AnimatedOpacity(
              // If the widget is visible, animate to 0.0 (invisible).
              // If the widget is hidden, animate to 1.0 (fully visible).
              opacity: _type == 'Domino' ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              // The green box must be a child of the AnimatedOpacity widget.
              child: Container(

                color: Colors.red,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(' + 100 :'),
                        Wrap(
                          children: _players.entries.map(
                                  (player) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {

                                      });
                                    },
                                    child: Text(player.key),
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
                        Wrap(
                          children: _players.entries.map(
                                  (player) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {

                                      });
                                    },
                                    child: Text(player.key),
                                  ),
                                );
                              }
                          ).toList(),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
