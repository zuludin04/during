import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final List<NavMenu> navMenus;
  final Function(int) onSelectedMenu;

  const BottomNavigation({
    super.key,
    required this.currentIndex,
    required this.navMenus,
    required this.onSelectedMenu,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -1),
            blurRadius: 1,
            color: Colors.black26,
          ),
        ],
      ),
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

  const _BottomNavItem({
    required this.menu,
    required this.index,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return menu.isCenter ? _centerMenu() : _normalMenu(context);
  }

  Widget _normalMenu(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/navigation/${menu.icon}.png',
          width: 20,
          height: 20,
          color: selected && index != 2
              ? const Color(0xffffa400)
              : index == 2
                  ? null
                  : Theme.of(context).iconTheme.color,
        ),
        const SizedBox(height: 2),
        Text(
          menu.label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: selected
                ? const Color(0xffffa400)
                : Theme.of(context).iconTheme.color,
          ),
        ),
      ],
    );
  }

  Widget _centerMenu() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffffa400),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(
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
