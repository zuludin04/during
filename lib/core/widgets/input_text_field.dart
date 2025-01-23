import 'package:during/core/utils/currency_formatter.dart';
import 'package:during/core/widgets/input_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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
  final bool enableValidation;

  InputTextField({
    super.key,
    required this.title,
    this.text = '',
    this.hint,
    this.onSaved,
    this.keyboardType = TextInputType.text,
    this.capitalization = TextCapitalization.words,
    this.currencyFormat = false,
    this.enable = true,
    this.enableValidation = true,
  });

  @override
  Widget build(BuildContext context) {
    return InputSection(
      title: title,
      child: TextFormField(
        enabled: enable,
        controller: controller..text = text,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.bodySmall,
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        cursorColor: Colors.blue,
        onSaved: (String? val) {
          if (currencyFormat) {
            String onlyDigits = val!.replaceAll(RegExp('[^0-9]'), "");
            onSaved?.value = onlyDigits;
          } else {
            onSaved?.value = val ?? '';
          }
        },
        validator: enableValidation ? _emptyValidator : null,
        keyboardType: keyboardType,
        textCapitalization: capitalization,
        inputFormatters: currencyFormat ? _inputFormatters() : [],
      ),
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
