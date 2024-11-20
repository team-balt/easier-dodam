import 'package:easier_dodam/component/theme/color.dart';
import 'package:easier_dodam/component/theme/style.dart';
import 'package:flutter/material.dart';

enum TagType { PENDING, APPROVE, REJECT }

class OutItem extends StatelessWidget {
  final TagType tagType;
  final Function() onClickTrash;
  final String? rejectReason;
  final TimeOfDay startAt;
  final TimeOfDay endAt;

  const OutItem({
    super.key,
    required this.tagType,
    required this.onClickTrash,
    this.rejectReason,
    required this.startAt,
    required this.endAt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, 4), // changes position of shadow
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
                    padding: EdgeInsets.symmetric(
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
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset("assets/images/ic_trash.png"),
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
                  "3시간",
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
                      "18시 30분",
                      style: EasierDodamStyles.label2,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "복귀",
                      style: EasierDodamStyles.label2.copyWith(
                        fontSize: 12.0,
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      "18시 30분",
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
