import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'header_text.dart';

class DateDialog extends StatefulWidget {
  final Function(int dateInMillisecond) selectedDate;
  final DateTime currentDate;

  const DateDialog({
    Key? key,
    required this.selectedDate,
    required this.currentDate,
  }) : super(key: key);

  @override
  _DateDialogState createState() => _DateDialogState();
}

class _DateDialogState extends State<DateDialog> {
  late DateTime _currentDate;
  late TimeOfDay _currentTime;

  late DateTime _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _currentDate = widget.currentDate;
    _currentTime =
        TimeOfDay(hour: _currentDate.hour, minute: _currentDate.minute);
    _changeDateTime();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              HeaderText(title: 'date'.tr, showTrailing: false),
              const SizedBox(height: 8),
              InkWell(
                onTap: () async {
                  var date = await showDatePicker(
                    context: context,
                    initialDate: _currentDate,
                    helpText: '',
                    cancelText: 'cancel'.tr,
                    confirmText: 'ok'.tr,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2025),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: Colors.blue,
                            onPrimary: Colors.white,
                            onSurface: Colors.grey,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (date != null) {
                    setState(() {
                      _currentDate = date;
                      _changeDateTime();
                      widget.selectedDate(
                          _selectedDateTime.millisecondsSinceEpoch);
                    });
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    _getCurrentDate(_currentDate),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              HeaderText(title: 'time'.tr, showTrailing: false),
              const SizedBox(height: 8),
              InkWell(
                onTap: () async {
                  var selectedTime = await showTimePicker(
                    context: context,
                    initialTime: _currentTime,
                    helpText: '',
                    cancelText: 'cancel'.tr,
                    confirmText: 'ok'.tr,
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: Colors.blue,
                            onPrimary: Colors.white,
                            onSurface: Colors.grey,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );

                  if (selectedTime != null) {
                    setState(() {
                      _currentTime = selectedTime;
                      _changeDateTime();
                      widget.selectedDate(
                          _selectedDateTime.millisecondsSinceEpoch);
                    });
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    '${_currentTime.hour}:${_currentTime.minute}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _changeDateTime() {
    _selectedDateTime = DateTime(_currentDate.year, _currentDate.month,
        _currentDate.day, _currentTime.hour, _currentTime.minute);
  }

  String _getCurrentDate(DateTime date) {
    initializeDateFormatting();
    var format = DateFormat("dd MMMM yyyy", "id");
    return format.format(date);
  }
}
