import 'package:easier_dodam/component/theme/color.dart';
import 'package:easier_dodam/component/theme/style.dart';
import 'package:flutter/material.dart';

class EasierDodamDefaultPresetAppbar extends StatelessWidget {
  final String title;
  final Function() onLeftArrowClick;

  const EasierDodamDefaultPresetAppbar({
    super.key,
    required this.title,
    required this.onLeftArrowClick,
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
                width: 48,
                height: 48,
                child: Center(
                  child: InkWell(
                    onTap: onLeftArrowClick,
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: Image.asset(
                        "assets/images/ic_arrow_left.png",
                        color: EasierDodamColors.gray600,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                title,
                style: EasierDodamStyles.title1,
              ),
              Expanded(child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}
