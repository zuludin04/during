import 'package:during/ui/transaction/controllers/transaction_create_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionType extends StatefulWidget {
  final TransactionCreateController controller;

  const TransactionType({super.key, required this.controller});

  @override
  State<TransactionType> createState() => _TransactionTypeState();
}

class _TransactionTypeState extends State<TransactionType> {
  var selectedType = 'Expense';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Theme.of(context).colorScheme.onPrimary),
      ),
      child: Row(
        children: [
          CategoryType(
            onTap: changeTypeState,
            isSelected: selectedType == 'Income',
            title: 'Income',
          ),
          CategoryType(
            onTap: changeTypeState,
            isSelected: selectedType == 'Expense',
            title: 'Expense',
          ),
        ],
      ),
    );
  }

  void changeTypeState(String type) {
    setState(() => selectedType = type);
    widget.controller.changeCategoryList(type);
    widget.controller.type.value = type;
  }
}

class CategoryType extends StatelessWidget {
  final Function(String type) onTap;
  final bool isSelected;
  final String title;

  const CategoryType({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => onTap(title),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected
                ? title == 'Income'
                    ? Colors.green
                    : Colors.red
                : Colors.transparent,
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
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
