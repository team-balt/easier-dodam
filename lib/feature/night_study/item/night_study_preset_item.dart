import 'package:easier_dodam/feature/night_study/item/night_study_item.dart';
import 'package:flutter/material.dart';

import '../../../component/theme/color.dart';
import '../../../component/theme/style.dart';

class NightStudyPresetItem extends StatelessWidget {
  final String presetTitle;
  final PlaceType place;
  final String content;
  final bool doNeedPhone;
  final String phoneReason;
  final DateTime startDate;
  final DateTime endDate;
  final Function() onTrashClick;
  final Function() onClickCreate;

  const NightStudyPresetItem({
    super.key,
    required this.presetTitle,
    required this.place,
    required this.content,
    required this.doNeedPhone,
    required this.phoneReason,
    required this.startDate,
    required this.endDate,
    required this.onTrashClick,
    required this.onClickCreate,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: EasierDodamColors.staticWhite,
      child: InkWell(
        onTap: onClickCreate,
        child: Padding(
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
                      presetTitle,
                      style: EasierDodamStyles.body2
                          .copyWith(color: EasierDodamColors.gray700),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "사유 : $content",
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
                          style:
                          EasierDodamStyles.body2.copyWith(fontSize: 12.0),
                        ),
                        Text(
                          " ${startDate.year}년 ${startDate.month}월 ${startDate.day}일 ",
                          style:
                          EasierDodamStyles.body2.copyWith(fontSize: 14.0),
                        ),
                        Expanded(child: SizedBox()),
                        Text(
                          "종료",
                          style:
                          EasierDodamStyles.body2.copyWith(fontSize: 12.0),
                        ),
                        Text(
                          " ${endDate.year}년 ${endDate.month}월 ${endDate.day}일 ",
                          style:
                          EasierDodamStyles.body2.copyWith(fontSize: 14.0),
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
        ),
      ),
    );
  }
}