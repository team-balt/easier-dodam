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

  @override
  void dispose(){
    _reasonTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
      child: ChangeNotifierProvider(
        create: (_) => NightStudyViewmodel(), 
        child: Consumer<NightStudyViewmodel>(
          builder: (context, provider, child){
            return Container(
              color: EasierDodamColors.staticWhite,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 23,
                  ),
                  Text(
                      "현재 신청된 심자",
                    style: EasierDodamStyles.body1,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                  ),
                ],
              ),
            );
            },
        ),
      ),
      ),
      bottomNavigationBar: SafeArea(
        child:
        CustomBottomNavigationBar(
            selectedIndex: _selectedIndex,
            onItemTapped: _onItemTapped),
      ),
    );
  }
}
