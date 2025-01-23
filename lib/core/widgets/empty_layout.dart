import 'package:flutter/material.dart';

class EmptyLayout extends StatelessWidget {
  final String message;

  const EmptyLayout({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/empty.png',
            width: 86.0,
            height: 86.0,
          ),
          const SizedBox(height: 4.0),
          Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
