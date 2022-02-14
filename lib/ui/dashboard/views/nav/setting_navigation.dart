import 'package:flutter/material.dart';

class SettingNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 5),
        _settingItem(
          'Rating',
          Icons.star,
          () {},
        ),
        _settingItem(
          'Share',
          Icons.share,
          () {},
        ),
        _settingItem(
          'Info',
          Icons.info,
          () {},
        ),
      ],
    );
  }

  Widget _settingItem(String title, IconData icon, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(icon, size: 24),
                SizedBox(width: 15),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Icon(Icons.keyboard_arrow_right_outlined),
              ],
            ),
          ),
          SizedBox(height: 2),
        ],
      ),
    );
  }
}
