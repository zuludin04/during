import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  final String title;
  final bool isMore;
  final String more;
  final double titleSize;
  final double moreSize;
  final Function()? onMoreTap;

  HeaderText({
    required this.title,
    required this.isMore,
    this.more = '',
    this.titleSize = 16,
    this.moreSize = 13,
    this.onMoreTap,
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
          visible: isMore,
          child: GestureDetector(
            onTap: onMoreTap,
            child: Text(
              more,
              style: TextStyle(
                fontSize: moreSize,
                color: Color(0xff757575),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        )
      ],
    );
  }
}
