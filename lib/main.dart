import 'package:easier_dodam/component/textfield.dart';
import 'package:easier_dodam/component/theme/color.dart';
import 'package:easier_dodam/feature/login/login_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';

import 'component/theme/style.dart';
import 'feature/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 추가
  await FlutterConfig.loadEnvVariables(); // 추가

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: "Pretendard",
        scaffoldBackgroundColor: EasierDodamColors.staticWhite,
      ),
      initialRoute: loginRoute,
      routes: {
        loginRoute: (context) => LoginScreen(),
        "test": (context) => Scaffold(
              body: Text("test"),
            )
      },
    );
  }
}
