import 'package:easier_dodam/component/theme/color.dart';
import 'package:easier_dodam/component/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OutSleepingCreateTimeItem extends StatelessWidget {
  final String title;
  final DateTime date;
  final Function() onButtonClick;

  const OutSleepingCreateTimeItem({
    super.key,
    required this.title,
    required this.date,
    required this.onButtonClick,
  });

  @override
  Widget build(BuildContext context) {
    final String formattedDate =
        "${DateFormat('yy.MM.dd').format(date)} (${_getDayOfWeek(date.weekday)})";

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
                formattedDate,
                style: EasierDodamStyles.label1.copyWith(
                  height: 1.5,
                  color: EasierDodamColors.staticBlack,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _getDayOfWeek(int weekday) {
    const days = ["월", "화", "수", "목", "금", "토", "일"];
    return days[weekday - 1];
  }
}
