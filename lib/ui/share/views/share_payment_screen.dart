// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:during/core/widgets/input_text_field.dart';
import 'package:during/core/widgets/toolbar_during.dart';
import 'package:during/ui/share/controllers/share_payment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SharePaymentScreen extends StatelessWidget {
  final SharePaymentController _controller = Get.find();
  final _formKey = GlobalKey<FormState>();

  SharePaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolbarDuring.defaultToolbar('share_payment'.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                InputTextField(
                  title: 'name'.tr,
                  hint: 'name'.tr,
                  onSaved: _controller.paymentName,
                ),
                const SizedBox(height: 16),
                InputTextField(
                  title: 'total_amount'.tr,
                  hint: 'total_amount'.tr,
                  keyboardType: TextInputType.number,
                  currencyFormat: true,
                  onSaved: _controller.paymentNominal,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                    }
                  },
                  child: Text(
                    'create_payment'.tr,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sharePayment() {
    // CollectionReference payments = FirebaseFirestore.instance
    //     .collection('sharepayment')
    //     .doc('userId')
    //     .collection('sharing');

    // payments.add({'restaurant': 'Hokben', 'price': 500000}).then((value) {
    //   debugPrint('success create payment: ${value.id}');
    // }).catchError(
    //   (error) {
    //     debugPrint('error when creating payment: $error');
    //   },
    // );
  }
}
