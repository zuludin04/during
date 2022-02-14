import 'package:flutter/material.dart';

class SettingNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _dashboardAppBar(),
          Expanded(
            child: ListView(
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _dashboardAppBar() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Color(0xff373A36),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              'ZM',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xffFFA400),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
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
