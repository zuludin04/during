import 'package:during/core/widgets/toolbar_during.dart';
import 'package:during/ui/share/views/widgets/payment_members.dart';
import 'package:flutter/material.dart';

class ShareGeneratedCodeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolbarDuring.defaultToolbar(
        'Share Payment',
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.qr_code_scanner,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.share,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          PaymentMembers(),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              border: Border.fromBorderSide(BorderSide(color: Colors.black12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total'),
                    const Text(
                      'Rp 100.000',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 24),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Finish',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.lightBlue),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(12))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
