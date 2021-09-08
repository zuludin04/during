import 'package:during/core/header_text.dart';
import 'package:flutter/material.dart';

class FormFieldSpinner extends StatefulWidget {
  final List<String> items;
  final String currentSelected;
  final Function(String) onSelect;
  final String title;

  FormFieldSpinner(
    this.items,
    this.currentSelected,
    this.onSelect,
    this.title,
  );

  @override
  _FormFieldSpinnerState createState() => _FormFieldSpinnerState();
}

class _FormFieldSpinnerState extends State<FormFieldSpinner> {
  late String selected;

  @override
  void initState() {
    super.initState();
    selected = widget.currentSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderText(title: widget.title, showTrailing: false),
        SizedBox(height: 8),
        FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                hintText: 'Please select expense',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
              ),
              isEmpty: selected == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selected,
                  isDense: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      _changeValue(state, newValue);
                    });
                  },
                  hint: Text('Select Category'),
                  items: widget.items.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _changeValue(FormFieldState<String> state, String? newValue) {
    selected = newValue!;
    widget.onSelect(newValue);
    state.didChange(newValue);
  }
}
