import 'package:easier_dodam/component/theme/color.dart';
import 'package:easier_dodam/component/bottom_navigation_bar.dart';
import 'package:easier_dodam/feature/login/login_navigation.dart';
import 'package:easier_dodam/feature/night_study/night_study_navigation.dart';
import 'package:easier_dodam/feature/out/out_navigation.dart';
import 'package:easier_dodam/feature/out_sleeping/out_sleeping_navigation.dart';
import 'package:flutter/material.dart';

import '../../component/appbar_no_icon.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({Key? key}) : super(key: key);

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  int _selectedIndex = 2;

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
          break;
        case 3:
          Navigator.pushReplacementNamed(context, nightStudyRoute);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: EasierDodamDefaultAppbarWithoutIcon(
          title: "설정",
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0, 4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: const ListTile(
                      title: Text(
                        '앱 버전',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      trailing: Text(
                        'v1.00',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0, 4),
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
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, loginRoute);
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
