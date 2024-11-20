import 'package:easier_dodam/component/textfield.dart';
import 'package:easier_dodam/component/theme/color.dart';
import 'package:easier_dodam/feature/login/login_navigation.dart';
import 'package:easier_dodam/feature/out/out.dart';
import 'package:easier_dodam/feature/out_create/out_create.dart';
import 'package:easier_dodam/feature/out_create/out_create_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:provider/provider.dart';

import 'component/theme/style.dart';
import 'feature/login/login.dart';
import 'feature/out/out_navigation.dart';
import 'feature/out/out_viewmodel.dart';

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
      initialRoute: outRoute,
      routes: {
        loginRoute: (context) => LoginScreen(),
        outRoute: (context) => ChangeNotifierProvider(
              create: (_) => OutViewModel(),
              child: OutScreen(),
            ),
        outCreateRoute: (context) => OutCreateScreen(),
        "test": (context) => Scaffold(
              body: Text("test"),
            )
      },
    );
  }
}
