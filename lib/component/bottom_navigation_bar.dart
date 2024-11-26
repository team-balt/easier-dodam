import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EasierDodamBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const EasierDodamBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            _buildNavItem(
              context,
              icon: 'assets/images/ic_bed.svg',
              label: '외박',
              index: 0,
            ),
            _buildNavItem(
              context,
              icon: 'assets/images/ic_door_open.svg',
              label: '외출',
              index: 1,
            ),
            _buildNavItem(
              context,
              icon: 'assets/images/ic_moon_plus.svg',
              label: '심야자습',
              index: 2,
            ),
            _buildNavItem(
              context,
              icon: 'assets/images/ic_gear.svg',
              label: '설정',
              index: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context,
      {required String icon, required String label, required int index}) {
    final isSelected = index == selectedIndex;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onItemTapped(index),
        onTapDown: (_) {
          debugPrint("tap down");
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: isSelected ? 30 : 24,
              width: isSelected ? 30 : 24,
              color: isSelected ? Colors.blue : Colors.grey,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.blue : Colors.grey,
                fontSize: isSelected ? 14 : 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
