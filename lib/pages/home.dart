import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  final double balance;

  Page1({required this.balance});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Current Balance',
          style: TextStyle(fontSize: 30.0),
        ),
        Text(
          '${balance.toStringAsFixed(2)}€',
          style: TextStyle(
            fontSize: 25.0,
            color: balance < 0 ? Colors.red : Colors.green,
          ),
        ),
      ],
    );
  }
}