import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final List<NavMenu> navMenus;
  final Function(int) onSelectedMenu;

  BottomNavigation({
    required this.currentIndex,
    required this.navMenus,
    required this.onSelectedMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -1),
              blurRadius: 5,
              color: Colors.black26,
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: navMenus
            .map((e) => InkWell(
                  onTap: () => onSelectedMenu(navMenus.indexOf(e)),
                  child: SizedBox.fromSize(
                    size: Size(
                      e.isCenter
                          ? 45
                          : MediaQuery.of(context).size.width / navMenus.length,
                      e.isCenter ? 45 : 64,
                    ),
                    child: _BottomNavItem(
                      menu: e,
                      selected: currentIndex == navMenus.indexOf(e),
                      index: navMenus.indexOf(e),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final NavMenu menu;
  final bool selected;
  final int index;

  _BottomNavItem({
    required this.menu,
    required this.index,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return menu.isCenter ? _centerMenu() : _normalMenu();
  }

  Widget _normalMenu() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/navigation/${menu.icon}.svg',
          width: 18,
          height: 18,
          color: selected && index != 2
              ? Colors.blue
              : index == 2
                  ? null
                  : Colors.black,
        ),
        SizedBox(height: 2),
        Text(
          menu.label,
          style: TextStyle(
            fontSize: 12,
            color: selected ? Colors.blue : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _centerMenu() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}

class NavMenu {
  final String label;
  final String icon;
  final bool isCenter;

  NavMenu({
    required this.label,
    required this.icon,
    this.isCenter = false,
  });
}
