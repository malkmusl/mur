import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  final double balance;

  const Page1({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text(
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
