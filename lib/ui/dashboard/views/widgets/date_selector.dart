import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateSelector extends StatefulWidget {
  final Function(DateTime date) selectedDate;
  final DateTime currentDate;

  const DateSelector({
    Key? key,
    required this.selectedDate,
    required this.currentDate,
  }) : super(key: key);

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  late DateTime _currentDate;

  late DateTime _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _currentDate = widget.currentDate;
    _changeDateTime();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var date = await showDatePicker(
          context: context,
          initialDate: _currentDate,
          helpText: '',
          cancelText: 'cancel'.tr,
          confirmText: 'ok'.tr,
          firstDate: DateTime(2020),
          lastDate: DateTime.now(),
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
            widget.selectedDate(_selectedDateTime);
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
    );
  }

  void _changeDateTime() {
    _selectedDateTime =
        DateTime(_currentDate.year, _currentDate.month, _currentDate.day);
  }

  String _getCurrentDate(DateTime date) {
    initializeDateFormatting();
    var format = DateFormat("dd MMMM yyyy", "id");
    return format.format(date);
  }
}
