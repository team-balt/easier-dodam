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
    return Container(
      height: 63,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 10,
            offset: Offset(0, -15),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            index: 3,
          ),
          _buildNavItem(
            context,
            icon: 'assets/images/ic_gear.svg',
            label: '설정',
            index: 2,
          ),

        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context,
      {required String icon, required String label, required int index}) {
    final isSelected = index == selectedIndex;

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
    );
  }
}