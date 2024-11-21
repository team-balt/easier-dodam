import 'package:easier_dodam/component/theme/color.dart';
import 'package:easier_dodam/component/theme/style.dart';
import 'package:flutter/material.dart';

class OutCreateTimeItem extends StatelessWidget {
  final String title;
  final String buttonText;
  final Function() onButtonClick;

  const OutCreateTimeItem(
      {super.key,
      required this.title,
      required this.buttonText,
      required this.onButtonClick});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: EasierDodamStyles.label1.copyWith(
            height: 1.5,
            color: EasierDodamColors.gray500,
          ),
        ),
        InkWell(
          onTap: onButtonClick,
          child: Container(
            decoration: BoxDecoration(
              border: const Border.fromBorderSide(
                BorderSide(width: 1.0, color: EasierDodamColors.gray500),
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 34.5,
              ),
              child: Text(
                buttonText,
                style: EasierDodamStyles.label1.copyWith(
                  height: 1.5,
                  color: EasierDodamColors.staticBlack,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
