import 'package:during/ui/transaction/controllers/transaction_create_controller.dart';
import 'package:flutter/material.dart';

class TransactionType extends StatefulWidget {
  final TransactionCreateController controller;

  TransactionType(this.controller);

  @override
  _TransactionTypeState createState() => _TransactionTypeState();
}

class _TransactionTypeState extends State<TransactionType> {
  List<bool> _typeSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        children: [
          CategoryType(() => changeTypeState(0), _typeSelected[0], 'Income'),
          CategoryType(() => changeTypeState(1), _typeSelected[1], 'Expense'),
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

  CategoryType(this.onTap, this.isSelected, this.title);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected
                ? title == 'Income'
                    ? Colors.green
                    : Colors.red
                : Colors.white,
            borderRadius: BorderRadius.circular(isSelected ? 5 : 0),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      blurRadius: 0,
                      spreadRadius: 1,
                      color: Colors.black26,
                    )
                  ]
                : null,
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(color: isSelected ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}
