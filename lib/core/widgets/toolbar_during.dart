import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToolbarDuring {
  static AppBar defaultToolbar(
    String title, {
    List<Widget> actions = const [],
    bool sharePayment = false,
    IconData leadingIcon = Icons.chevron_left_rounded,
    PreferredSizeWidget? tabs,
  }) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          if (sharePayment) {
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
          } else {
            Get.back();
          }
        },
        icon: Icon(leadingIcon),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18),
      ),
      centerTitle: true,
      elevation: 0.5,
      actions: actions,
      bottom: tabs,
    );
  }
}
