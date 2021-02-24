import 'package:flutter/material.dart';

class CounterView extends StatefulWidget {
  final int initNumber;
  final int maxNumber;
  final Function(int) counterCallback;

  CounterView({this.initNumber, this.maxNumber, this.counterCallback});
  @override
  _CounterViewState createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  int _currentCount;
  Function _counterCallback;
  
  @override
  void initState() {
    super.initState();
    _currentCount = widget.initNumber ?? 1;
    _counterCallback = widget.counterCallback ?? (int number) {};
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _dec(() => _dicrement()),
          SizedBox(width: 13,),
          Text(_currentCount.toString(), style: TextStyle(fontSize: 20),),
          SizedBox(width: 10,),
          _inc(() => _increment()),
        ],
      ),
    );
  }

  void _increment() {
    setState(() {
      if (_currentCount < widget.maxNumber) {
        _currentCount++;
        _counterCallback(_currentCount);
      }
    });
  }

  void _dicrement() {
    setState(() {
      if (_currentCount > 0) {
        _currentCount--;
        _counterCallback(_currentCount);
      }
    });
  }

  Widget _dec(Function onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15,0,15,0),
        child: Text("-", style: TextStyle(fontSize: 30),),
      ),
    );
  }
  Widget _inc(Function onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15,0,15,0),
        child: Text("+", style: TextStyle(fontSize: 30),),
      ),
    );
  }
}