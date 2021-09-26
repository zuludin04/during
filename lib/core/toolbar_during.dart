import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToolbarDuring {
  static AppBar defaultToolbar(String title,
      {List<Widget> actions = const []}) {
    return AppBar(
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(
          Icons.chevron_left_rounded,
          color: Color(0xff111410),
        ),
      ),
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: TextStyle(color: Color(0xff111410), fontSize: 18),
      ),
      centerTitle: true,
      elevation: 0,
      actions: actions,
    );
  }
}
