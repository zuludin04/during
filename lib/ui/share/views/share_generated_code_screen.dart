import 'package:during/core/widgets/toolbar_during.dart';
import 'package:during/ui/share/views/widgets/payment_members.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShareGeneratedCodeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.defaultDialog(
          title: 'Close Payment',
          content: Text('All data will be erased. Are you sure?'),
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
                    insetPadding: EdgeInsets.symmetric(horizontal: 20),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(
                              'Scan this QR',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Container(
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
                border:
                    Border.fromBorderSide(BorderSide(color: Colors.black12)),
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
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(12))),
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
