import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../component/theme/color.dart';
import '../../../component/theme/style.dart';
import '../../../utiles/utile.dart';

enum TagType { PENDING, APPROVE, REJECT }
enum PlaceType { PROGRAMMING_1, PROGRAMMING_2, PROGRAMMING_3 }

extension PlaceTypeExtension on PlaceType {
  String get name {
    switch (this) {
      case PlaceType.PROGRAMMING_1:
        return "프로그래밍1실";
      case PlaceType.PROGRAMMING_2:
        return "프로그래밍2실";
      case PlaceType.PROGRAMMING_3:
        return "프로그래밍3실";
    }
  }
}

  class NightStudyItem extends StatelessWidget {

    final TagType tagType;
    final Function() onClickTrash;
    final String? rejectReason;
    final DateTime startAt;
    final DateTime endAt;

    const NightStudyItem({
      super.key,
      required this.tagType,
      required this.onClickTrash,
      this.rejectReason,
      required this.startAt,
      required this.endAt,
    });

  @override
  Widget build(BuildContext context) {

    final day = dateDifferenceInDays(DateTime.now(), endAt);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: switch (tagType) {
                      TagType.PENDING => EasierDodamColors.gray600,
                      TagType.APPROVE => EasierDodamColors.primary300,
                      TagType.REJECT => EasierDodamColors.staticRed
                    },
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 10.0,
                    ),
                    child: Text(
                      switch (tagType) {
                        TagType.PENDING => "대기중",
                        TagType.APPROVE => "수락됨",
                        TagType.REJECT => "거절됨",
                      },
                      style: EasierDodamStyles.label1.copyWith(
                        fontSize: 12.0,
                        color: EasierDodamColors.staticWhite,
                      ),
                    ),
                  ),
                ),
                Material(
                  color: EasierDodamColors.staticWhite,
                  child: InkWell(
                    onTap: onClickTrash,
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: Image.asset("assets/images/ic_trash.png"),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "$day일 남음",
                  style: EasierDodamStyles.label2,
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  "남음",
                  style: EasierDodamStyles.label2.copyWith(
                    fontSize: 12.0,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "시작",
                      style: EasierDodamStyles.label2.copyWith(
                        fontSize: 12.0,
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      "${startAt.year}-${startAt.month}-${startAt.day}일",
                      style: EasierDodamStyles.label2,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "종료",
                      style: EasierDodamStyles.label2.copyWith(
                        fontSize: 12.0,
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      "${endAt.year}-${endAt.month}-${endAt.day}일",
                      style: EasierDodamStyles.label2,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
