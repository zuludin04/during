import 'package:during/core/header_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateDialog extends StatefulWidget {
  final Function(int dateInMillisecond) selectedDate;

  DateDialog(this.selectedDate);

  @override
  _DateDialogState createState() => _DateDialogState();
}

class _DateDialogState extends State<DateDialog> {
  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderText(title: 'Date', isMore: false),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            var date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2021),
              lastDate: DateTime(2025),
            );
            if (date != null) {
              setState(() {
                _dateTime = date;
                widget.selectedDate(date.millisecondsSinceEpoch);
              });
            }
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black38),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              _getCurrentDate(_dateTime),
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }

  String _getCurrentDate(DateTime date) {
    initializeDateFormatting();
    var format = DateFormat("dd MMMM yyyy", "id");
    return format.format(date);
  }
}
