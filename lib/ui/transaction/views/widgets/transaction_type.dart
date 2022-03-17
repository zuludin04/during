import 'package:during/ui/transaction/controllers/transaction_create_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionType extends StatefulWidget {
  final TransactionCreateController controller;

  const TransactionType({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _TransactionTypeState createState() => _TransactionTypeState();
}

class _TransactionTypeState extends State<TransactionType> {
  late List<bool> _typeSelected;

  @override
  void initState() {
    if (widget.controller.type.value == 'Income') {
      _typeSelected = [true, false];
    } else {
      _typeSelected = [false, true];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        children: [
          CategoryType(
            onTap: () => changeTypeState(0),
            isSelected: _typeSelected[0],
            title: 'Income',
          ),
          CategoryType(
            onTap: () => changeTypeState(1),
            isSelected: _typeSelected[1],
            title: 'Expense',
          ),
        ],
      ),
    );
  }

  void changeTypeState(int index) {
    setState(() {
      for (int indexBtn = 0; indexBtn < _typeSelected.length; indexBtn++) {
        if (indexBtn == index) {
          _typeSelected[indexBtn] = true;
          widget.controller
              .changeCategoryList(index == 0 ? 'Income' : 'Expense');
          widget.controller.type.value = index == 0 ? 'Income' : 'Expense';
        } else {
          _typeSelected[indexBtn] = false;
        }
      }
    });
  }
}

class CategoryType extends StatelessWidget {
  final Function() onTap;
  final bool isSelected;
  final String title;

  const CategoryType({
    Key? key,
    required this.onTap,
    required this.isSelected,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected
                ? title == 'Income'
                    ? Colors.green
                    : Colors.red
                : Colors.white,
            borderRadius: BorderRadius.circular(isSelected ? 5 : 0),
            boxShadow: isSelected
                ? [
                    const BoxShadow(
                      blurRadius: 0,
                      spreadRadius: 1,
                      color: Colors.black26,
                    )
                  ]
                : null,
          ),
          child: Text(
            title.toLowerCase().tr,
            textAlign: TextAlign.center,
            style: TextStyle(color: isSelected ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}
