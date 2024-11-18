import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: SafeArea(
      //     // child: ChangeNotifierProvider(
      //
      //     )
      // ),
    );
  }
}
