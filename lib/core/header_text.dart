import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  final String title;
  final bool showTrailing;
  final String more;
  final double titleSize;
  final double moreSize;
  final Widget? trailing;
  final Function()? onTrailingTap;

  HeaderText({
    required this.title,
    required this.showTrailing,
    this.more = '',
    this.titleSize = 16,
    this.moreSize = 13,
    this.trailing,
    this.onTrailingTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: titleSize,
            color: Colors.black,
            fontWeight: FontWeight.w800,
          ),
        ),
        Visibility(
          visible: showTrailing,
          child: GestureDetector(
            onTap: onTrailingTap,
            child: trailing ?? _trailingMoreWidget(),
          ),
        )
      ],
    );
  }

  Widget _trailingMoreWidget() {
    return Text(
      more,
      style: TextStyle(
        fontSize: moreSize,
        color: Color(0xff757575),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
