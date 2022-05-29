import 'package:during/core/widgets/toolbar_during.dart';
import 'package:during/ui/share/views/widgets/payment_members.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShareGeneratedCodeScreen extends StatelessWidget {
  const ShareGeneratedCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.defaultDialog(
          title: 'Close Payment',
          content: const Text('All data will be erased. Are you sure?'),
          cancel: TextButton(
            onPressed: Get.back,
            child: const Text('Cancel'),
          ),
          confirm: TextButton(
            onPressed: () {
              Get.back();
              Get.back();
            },
            child: const Text('Yes'),
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: ToolbarDuring.defaultToolbar(
          'Share Payment',
          sharePayment: true,
          leadingIcon: Icons.close,
          actions: [
            IconButton(
              onPressed: () {
                Get.dialog(
                  AlertDialog(
                    insetPadding: const EdgeInsets.symmetric(horizontal: 20),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Scan this QR',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          SizedBox(
                            width: 250,
                            height: 250,
                            child: QrImage(
                              size: 250,
                              errorStateBuilder: (context, error) =>
                                  Text(error.toString()),
                              data: "some data",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.qr_code_scanner,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            const PaymentMembers(),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                border:
                    Border.fromBorderSide(BorderSide(color: Colors.black12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Total'),
                      Text(
                        'Rp 100.000',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 24),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.lightBlue),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(12))),
                    child: const Text(
                      'Finish',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
