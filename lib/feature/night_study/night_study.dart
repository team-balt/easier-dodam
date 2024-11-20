import 'package:easier_dodam/component/appbar.dart';
import 'package:easier_dodam/component/bottom_navigation_bar.dart';
import 'package:easier_dodam/component/theme/color.dart';
import 'package:easier_dodam/component/theme/style.dart';
import 'package:easier_dodam/feature/night_study/night_study_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NightStudyScreen extends StatefulWidget {
  const NightStudyScreen({super.key});

  @override
  State<NightStudyScreen> createState() => _NightStudyScreenState();
}

class _NightStudyScreenState extends State<NightStudyScreen> {
  final TextEditingController _reasonTextFieldController = TextEditingController();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPlusClick() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("심자 추가"),
        content: Text("심자를 추가하시겠습니까?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("취소"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("확인"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _reasonTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: EasierDodamDefaultAppbar(
          title: '심자',
          onPlusClick: _onPlusClick,
        ),
      ),
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (_) => NightStudyViewmodel(),
          child: Consumer<NightStudyViewmodel>(
            builder: (context, provider, child) {
              return Container(
                color: EasierDodamColors.staticWhite,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 23),
                    Text(
                      "현재 신청된 심자",
                      style: EasierDodamStyles.body1,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(),
                    // You can add more content here
                  ],
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(child: EasierDodamBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      ),
    );
  }
}