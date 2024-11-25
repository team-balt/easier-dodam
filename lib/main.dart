import 'package:easier_dodam/component/theme/color.dart';
import 'package:easier_dodam/feature/login/login_navigation.dart';
import 'package:easier_dodam/feature/night_study/night_study_create/night_study_create.dart';
import 'package:easier_dodam/feature/night_study/night_study_viewmodel.dart';
import 'package:easier_dodam/feature/out/out.dart';
import 'package:easier_dodam/feature/out_create/out_create.dart';
import 'package:easier_dodam/feature/out_create/out_create_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:provider/provider.dart';

import 'feature/login/login.dart';
import 'feature/night_study/night_study.dart';
import 'feature/night_study/night_study_create/night_study_create_navigation.dart';
import 'feature/night_study/night_study_navigation.dart';
import 'feature/out/out_navigation.dart';
import 'feature/out/out_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: "Pretendard",
        scaffoldBackgroundColor: EasierDodamColors.staticWhite,
      ),
      initialRoute: loginRoute,
      routes: {
        nightStudyRoute: (context) => ChangeNotifierProvider(
          create: (_) => NightStudyViewmodel(),
          child: NightStudyScreen(),
        ),
        loginRoute: (context) => LoginScreen(),
        outRoute: (context) => ChangeNotifierProvider(
          create: (_) => OutViewModel(),
          child: OutScreen(),
        ),
        outCreateRoute: (context) => OutCreateScreen(),
        nightStudyCreateRoute: (context) => NightStudyCreateScreen(),
      },
    );
  }
}
