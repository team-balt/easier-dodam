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
  try {
    await FlutterConfig.loadEnvVariables();
  } catch (e) {
    debugPrint('Failed to load environment variables: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NightStudyViewmodel()),
        ChangeNotifierProvider(create: (_) => OutViewModel()),
      ],
      child: MaterialApp(
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
          nightStudyRoute: (context) => NightStudyScreen(),
          loginRoute: (context) => LoginScreen(),
          outRoute: (context) => OutScreen(),
          outCreateRoute: (context) => OutCreateScreen(),
          nightStudyCreateRoute: (context) => NightStudyCreateScreen(),
        },
        home: const SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, loginRoute);
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: EasierDodamColors.staticWhite,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/ic_splash.png',
                  width: 200,
                ),
                const SizedBox(height: 16),
                Text(
                  "도담도담을 쉽게",
                  style: TextStyle(
                    color: EasierDodamColors.primary300,
                  ),
                ),
                const SizedBox(height: 16),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                    EasierDodamColors.primary300,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}