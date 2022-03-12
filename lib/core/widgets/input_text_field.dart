import 'package:during/core/utils/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'header_text.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  final String? hint;
  final RxString? onSaved;
  final TextInputType? keyboardType;
  final TextCapitalization capitalization;
  final bool currencyFormat;
  final String title;
  final String text;
  final bool enable;

  InputTextField({
    Key? key,
    required this.title,
    this.text = '',
    this.hint,
    this.onSaved,
    this.keyboardType = TextInputType.text,
    this.capitalization = TextCapitalization.words,
    this.currencyFormat = false,
    this.enable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderText(title: title, showTrailing: false),
        const SizedBox(height: 8),
        TextFormField(
          enabled: enable,
          controller: controller..text = text,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            border: OutlineInputBorder(
              borderSide: const BorderSide(),
              borderRadius: BorderRadius.circular(5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black38),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onSaved: (String? val) {
            if (currencyFormat) {
              String _onlyDigits = val!.replaceAll(RegExp('[^0-9]'), "");
              onSaved?.value = _onlyDigits;
            } else {
              onSaved?.value = val ?? '';
            }
          },
          validator: _emptyValidator,
          keyboardType: keyboardType,
          textCapitalization: capitalization,
          inputFormatters: currencyFormat ? _inputFormatters() : [],
        ),
      ],
    );
  }

  List<TextInputFormatter> _inputFormatters() {
    return [
      FilteringTextInputFormatter.digitsOnly,
      CurrencyFormatter(),
    ];
  }

  String? _emptyValidator(String? value) {
    if (value!.isEmpty) {
      return "Field can't be empty";
    }
    return null;
  }
}
