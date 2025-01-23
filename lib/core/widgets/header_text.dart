import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  final String title;
  final bool showTrailing;
  final String more;
  final double titleSize;
  final double moreSize;
  final Widget? trailing;
  final Function()? onTrailingTap;

  const HeaderText({
    super.key,
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
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: titleSize,
                fontWeight: FontWeight.w800,
              ),
        ),
        Visibility(
          visible: showTrailing,
          child: InkWell(
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
        color: const Color(0xff757575),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
