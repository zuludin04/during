import 'package:during/core/widgets/toolbar_during.dart';
import 'package:flutter/material.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolbarDuring.defaultToolbar('Transfer'),
    );
  }
}
