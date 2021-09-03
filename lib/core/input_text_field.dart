import 'package:during/core/currency_formatter.dart';
import 'package:during/core/header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class InputTextField extends StatelessWidget {
  final String? hint;
  final RxString? onSaved;
  final TextInputType? keyboardType;
  final TextCapitalization capitalization;
  final bool currencyFormat;
  final String title;

  InputTextField({
    required this.title,
    this.hint,
    this.onSaved,
    this.keyboardType = TextInputType.text,
    this.capitalization = TextCapitalization.words,
    this.currencyFormat = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderText(title: title, isMore: false),
        SizedBox(height: 8),
        Container(
          child: TextFormField(
            decoration: InputDecoration(
              hintText: hint,
              contentPadding: EdgeInsets.symmetric(horizontal: 8),
              border: OutlineInputBorder(
                borderSide: BorderSide(),
                borderRadius: BorderRadius.circular(5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black38),
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
    if (value?.length == 0) {
      return "Field can\'t be empty";
    }
    return null;
  }
}
