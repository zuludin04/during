import 'package:during/core/widgets/toolbar_during.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/date_dialog.dart';
import '../../../core/widgets/header_text.dart';
import '../../../core/widgets/input_text_field.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolbarDuring.defaultToolbar(
        'Transfer',
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.check,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const HeaderText(title: 'Dari', showTrailing: false),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black38),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(
                              'Choose Saving',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      children: [
                        const HeaderText(title: 'Ke', showTrailing: false),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black38),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(
                              'Choose Saving',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              InputTextField(
                title: 'total'.tr,
                hint: 'total'.tr,
                onSaved: '0'.obs,
                keyboardType: TextInputType.phone,
                currencyFormat: true,
              ),
              const SizedBox(height: 16),
              DateDialog(
                selectedDate: (int date) {},
                currentDate: DateTime.now(),
              ),
              const SizedBox(height: 16),
              InputTextField(
                title: 'fee'.tr,
                hint: 'fee'.tr,
                onSaved: '0'.obs,
                keyboardType: TextInputType.phone,
                currencyFormat: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
