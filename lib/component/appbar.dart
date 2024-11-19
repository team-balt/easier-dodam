import 'package:easier_dodam/component/theme/color.dart';
import 'package:easier_dodam/component/theme/style.dart';
import 'package:flutter/material.dart';

class EasierDodamDefaultAppbar extends StatelessWidget {
  final String title;
  final Function() onPlusClick;

  const EasierDodamDefaultAppbar({
    super.key,
    required this.title,
    required this.onPlusClick,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EasierDodamColors.staticWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 12,
              ),
              Text(
                title,
                style: EasierDodamStyles.title1,
              ),
              Expanded(child: SizedBox()),
              SizedBox(
                width: 48,
                height: 48,
                child: Center(
                  // 자식 위젯을 중앙 정렬
                  child: InkWell(
                    onTap: onPlusClick,
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: Image.asset(
                        "assets/images/ic_plus.png",
                        color: EasierDodamColors.gray600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
