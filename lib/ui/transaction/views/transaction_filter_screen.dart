import 'package:during/core/toolbar_during.dart';
import 'package:flutter/material.dart';

class TransactionFilterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolbarDuring.defaultToolbar('Records'),
      body: Center(
        child: Text('Transaction Record'),
      ),
    );
  }
}