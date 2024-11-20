import 'package:easier_dodam/component/theme/color.dart';
import 'package:easier_dodam/component/theme/style.dart';
import 'package:flutter/material.dart';

class OutPresetItem extends StatelessWidget {
  final String title;
  final String reason;
  final String startAt;
  final String endAt;
  final Function() onTrashClick;

  const OutPresetItem({
    super.key,
    required this.title,
    required this.reason,
    required this.startAt,
    required this.endAt,
    required this.onTrashClick,
  });

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
                  title,
                  style: EasierDodamStyles.body2
                      .copyWith(color: EasierDodamColors.gray700),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "사유 : $reason",
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
                      " $startAt",
                      style: EasierDodamStyles.body2.copyWith(fontSize: 14.0),
                    ),
                    Expanded(child: SizedBox()),
                    Text(
                      "복귀",
                      style: EasierDodamStyles.body2.copyWith(fontSize: 12.0),
                    ),
                    Text(
                      " $endAt",
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
            child: InkWell(
              onTap: onTrashClick,
              child: Image.asset(
                "assets/images/ic_trash.png",
                color: EasierDodamColors.gray700,
              ),
            ),
          )
        ],
      ),
    );
  }
}
