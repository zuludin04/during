import 'package:during/core/widgets/input_text_field.dart';
import 'package:during/core/widgets/toolbar_during.dart';
import 'package:during/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SharePaymentScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolbarDuring.defaultToolbar('Share Payment'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                InputTextField(
                  title: 'Name',
                  hint: 'Name',
                ),
                const SizedBox(height: 16),
                InputTextField(
                  title: 'Total Amount',
                  hint: 'Total Amount',
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(RoutePath.GENERATED_CODE);
                  },
                  child: const Text('Generate Code'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
