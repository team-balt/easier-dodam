import 'package:easier_dodam/component/theme/color.dart';
import 'package:easier_dodam/component/theme/style.dart';
import 'package:flutter/material.dart';

class OutPresetItem extends StatelessWidget {
  const OutPresetItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "프리셋#1",
                  style: EasierDodamStyles.body2
                      .copyWith(color: EasierDodamColors.gray700),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "사유 : ㅈㅂㄷㅂㅈㄷㅈㄷ",
                  style: EasierDodamStyles.body2
                      .copyWith(color: EasierDodamColors.gray600),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text(
                      "시작",
                      style: EasierDodamStyles.body2.copyWith(fontSize: 12.0),
                    ),
                    Text(
                      " 13시 50분",
                      style: EasierDodamStyles.body2.copyWith(fontSize: 14.0),
                    ),
                    Expanded(child: SizedBox()),
                    Text(
                      "복귀",
                      style: EasierDodamStyles.body2.copyWith(fontSize: 12.0),
                    ),
                    Text(
                      " 13시 50분",
                      style: EasierDodamStyles.body2.copyWith(fontSize: 14.0),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            width: 4,
          ),
          SizedBox(
            width: 24,
            height: 24,
            child: Image.asset(
              "assets/images/ic_trash.png",
              color: EasierDodamColors.gray700,
            ),
          )
        ],
      ),
    );
  }
}
