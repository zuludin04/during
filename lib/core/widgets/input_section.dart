import 'package:flutter/material.dart';

import 'header_text.dart';

class InputSection extends StatelessWidget {
  final String title;
  final Widget child;

  const InputSection({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderText(title: title, showTrailing: false),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.onPrimary),
            borderRadius: BorderRadius.circular(5),
          ),
          child: child,
        ),
      ],
    );
  }
}
