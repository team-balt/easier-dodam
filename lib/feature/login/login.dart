import 'package:easier_dodam/component/textfield.dart';
import 'package:easier_dodam/component/theme/color.dart';
import 'package:easier_dodam/component/theme/style.dart';
import 'package:easier_dodam/feature/login/login_viewmodel.dart';
import 'package:easier_dodam/feature/out/out_navigation.dart';
import 'package:flutter/material.dart';
import "package:provider/provider.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idTextFieldController = TextEditingController();
  final TextEditingController _pwTextFieldController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _idTextFieldController.dispose();
    _pwTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (_) => LoginViewmodel(),
          child: Consumer<LoginViewmodel>(
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
                      "도담도담 계정을 입력해주세요",
                      style: EasierDodamStyles.title1,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    EasierDodamTextField(
                      labelText: "아이디",
                      hintText: "도담도담 아이디를 입력해주세요.",
                      controller: _idTextFieldController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    EasierDodamTextField(
                      labelText: "비밀번호",
                      hintText: "도담도담 비밀번호를 입력해주세요.",
                      obscureText: true,
                      controller: _pwTextFieldController,
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
                        onPressed: () async {
                          final isSuccess = await provider.login(
                            _idTextFieldController.text,
                            _pwTextFieldController.text,
                          );

                          if (isSuccess) {
                            Navigator.pushReplacementNamed(
                              context,
                              outRoute,
                            );
                          }
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
        ),
      ),
    );
  }
}
