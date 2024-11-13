import 'package:easier_dodam/component/textfield.dart';
import 'package:easier_dodam/component/theme/color.dart';
import 'package:easier_dodam/component/theme/style.dart';
import 'package:easier_dodam/feature/login/loginViewModel.dart';
import 'package:flutter/material.dart';
import "package:provider/provider.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: Consumer<LoginViewModel>(
        builder: (context, provider, child) {
          // testState = provider.testState;
          return Container(
            color: EasierDodamColors.staticWhite,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24,
                ),
                Text(
                  "도담도담 계정을 입력해주세요" + context.watch<LoginViewModel>().testState,
                  style: EasierDodamStyles.title1,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 10,
                ),
                EasierDodamTextField(
                  labelText: "아이디",
                  hintText: "도담도담 아이디를 입력해주세요.",
                ),
                SizedBox(
                  height: 10,
                ),
                EasierDodamTextField(
                  labelText: "비밀번호",
                  hintText: "도담도담 비밀번호를 입력해주세요.",
                  obscureText: true,
                ),
                Expanded(child: SizedBox()),
                SizedBox(
                  width: double.infinity,
                  height: 56.0,
                  child: MaterialButton(
                    height: 56.0,
                    color: EasierDodamColors.primary300,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Text(
                      "로그인",
                      style: EasierDodamStyles.body2,
                    ),
                    textColor: EasierDodamColors.staticWhite,
                    onPressed: () {
                      provider.testSet();
                    },
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
