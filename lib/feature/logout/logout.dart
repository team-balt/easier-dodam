import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../component/appbar.dart';
import '../../component/theme/color.dart';
import '../../component/bottom_navigation_bar.dart';
import '../../feature/login/login_navigation.dart';
import '../../feature/night_study/night_study_navigation.dart';
import '../../feature/out/out_navigation.dart';
import '../../feature/out_sleeping/out_sleeping_navigation.dart';
import '../logout/logout_viewmodel.dart';
import 'item/setting_item.dart';
import 'logout_navigation.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, outSleepingRoute);
          break;
        case 1:
          Navigator.pushReplacementNamed(context, outRoute);
          break;
        case 2:
          Navigator.pushReplacementNamed(context, nightStudyRoute);
          break;
        case 3:
          Navigator.pushReplacementNamed(context, logoutRoute);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SettingViewModel>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: EasierDodamDefaultAppbar(
          title: "설정",
          colors: EasierDodamColors.staticWhite,
          onPlusClick: () {},
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SettingList(
                    title: '앱 버전',
                    trailing: 'v1.00',
                  ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(0, 4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: EasierDodamColors.primary300,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        onPressed: () async {
                          final success = await viewModel.logout();
                          if (success) {
                            Navigator.pushReplacementNamed(context, loginRoute);
                          }
                        },
                        child: const Text(
                          '로그아웃',
                          style: TextStyle(
                            color: EasierDodamColors.staticWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: EasierDodamBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
