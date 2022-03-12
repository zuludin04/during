import 'package:flutter/material.dart';

class PaymentMembers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Member #${index + 1}'),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
