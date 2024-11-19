import 'package:easier_dodam/component/theme/color.dart';
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


  @override
  void dispose(){
    _reasonTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold(
    //   body: SafeArea(
    //     child: ChangeNotifierProvider(
    //       create: (_) => NightStudyViewmodel(),
    //       child: Consumer<NightStudyViewmodel>(
    //         builder: (context, provider, child) {
    //           return Container(
    //             color: EasierDodamColors.staticWhite,
    //             margin: const EdgeInsets.symmetric(horizontal: 16),
    //             child: Text("data"),
    //
    //             //   Column(
    //             //     crossAxisAlignment: CrossAxisAlignment.start,
    //             //     children: [
    //             //       SizedBox(
    //             //         height: 24,
    //             //         width: 24,
    //             //       ),
    //             //     ],
    //             //   ),
    //             // );
    //           );
    //         },
    //       ),
    //     ),
    //   ),
    // );
    return Scaffold(
      body: SafeArea(
      child: ChangeNotifierProvider(
        create: (_) => NightStudyViewmodel(), 
        child: Consumer<NightStudyViewmodel>(
          builder: (context, provider, child){
            return Container(
              color: EasierDodamColors.staticWhite,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("data"),
            );
            },
        ),
      ),
      ),
    );
  }
}
