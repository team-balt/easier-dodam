import 'package:easier_dodam/component/theme/color.dart';
import 'package:easier_dodam/component/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDateWithDay(DateTime date) {
  const weekDays = ["월", "화", "수", "목", "금", "토", "일"];
  return DateFormat('yy.MM.dd').format(date) +
      "(${weekDays[date.weekday - 1]})";
}

class OutSleepingPresetItem extends StatelessWidget {
  final String title;
  final String reason;
  final DateTime startAt;
  final DateTime endAt;
  final Function() onTrashClick;
  final Function() onClick;

  const OutSleepingPresetItem({
    super.key,
    required this.title,
    required this.reason,
    required this.startAt,
    required this.endAt,
    required this.onTrashClick,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: EasierDodamColors.staticWhite,
      child: InkWell(
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "사유 : $reason",
                      style: EasierDodamStyles.body2
                          .copyWith(color: EasierDodamColors.gray600),
                    ),
                    const SizedBox(
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
                          " ${formatDateWithDay(startAt)}",
                          style:
                              EasierDodamStyles.body2.copyWith(fontSize: 14.0),
                        ),
                        const Expanded(child: SizedBox()),
                        Text(
                          "복귀",
                          style:
                              EasierDodamStyles.body2.copyWith(fontSize: 12.0),
                        ),
                        Text(
                          " ${formatDateWithDay(endAt)}",
                          style:
                              EasierDodamStyles.body2.copyWith(fontSize: 14.0),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
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

enum TagType { PENDING, APPROVE, REJECT }

class OutSleepingItem extends StatelessWidget {
  final TagType tagType;
  final Function() onClickTrash;
  final String? rejectReason;
  final DateTime startAt;
  final DateTime endAt;

  const OutSleepingItem({
    super.key,
    required this.tagType,
    required this.onClickTrash,
    this.rejectReason,
    required this.startAt,
    required this.endAt,
  });

  @override
  Widget build(BuildContext context) {
    final difference = endAt.difference(DateTime.now());
    final hour = difference.inHours;
    final minute = difference.inMinutes % 60;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 4),
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
                  hour > 0 ? "$hour시간" : "$minute분",
                  style: EasierDodamStyles.label2,
                ),
                const SizedBox(
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
                    const SizedBox(width: 2),
                    Text(
                      formatDateWithDay(startAt),
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
                    const SizedBox(width: 2),
                    Text(
                      formatDateWithDay(endAt),
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
