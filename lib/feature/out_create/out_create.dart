import 'package:easier_dodam/component/preset_appbar.dart';
import 'package:easier_dodam/component/textfield.dart';
import 'package:easier_dodam/component/theme/color.dart';
import 'package:easier_dodam/component/theme/style.dart';
import 'package:flutter/material.dart';

import '../../utiles/utile.dart';
import 'item/out_create_time_item.dart';

class OutCreateScreen extends StatefulWidget {
  const OutCreateScreen({super.key});

  @override
  State<OutCreateScreen> createState() => _OutCreateScreenState();
}

class _OutCreateScreenState extends State<OutCreateScreen> {
  final TextEditingController _titleTextFieldController =
      TextEditingController();
  final TextEditingController _reasonTextFieldController =
      TextEditingController();

  TimeOfDay startAt = TimeOfDay.now();
  TimeOfDay endAt = adjustTimeOfDay(TimeOfDay.now(), hoursToAdd: 3);

  @override
  void dispose() {
    _titleTextFieldController.dispose();
    _reasonTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: EasierDodamDefaultPresetAppbar(
          title: "외출 프리셋 생성하기",
          onLeftArrowClick: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              EasierDodamTextField(
                labelText: "프리셋 제목",
                hintText: "프리셋 제목을 입력해주세요.",
                controller: _titleTextFieldController,
              ),
              SizedBox(
                height: 12,
              ),
              EasierDodamTextField(
                labelText: "사유",
                hintText: "외출 사유를 입력해주세요.",
                controller: _reasonTextFieldController,
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  OutCreateTimeItem(
                    title: "외출 시작",
                    buttonText: "${startAt.hour}시 ${startAt.minute}분",
                    onButtonClick: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time == null) {
                        return;
                      }
                      final diffMin = timeOfDayDifference(time, endAt);
                      setState(() {
                        startAt = time;
                        if (diffMin < 0) {
                          endAt = time;
                        }
                      });
                    },
                  ),
                  OutCreateTimeItem(
                    title: "외출 종료",
                    buttonText: "${endAt.hour}시 ${endAt.minute}분",
                    onButtonClick: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time == null) {
                        return;
                      }
                      setState(() {
                        endAt = time;
                      });
                    },
                  ),
                ],
              ),
              Expanded(child: SizedBox()),
              SizedBox(
                width: double.infinity,
                height: 56.0,
                child: MaterialButton(
                  height: 56.0,
                  color: EasierDodamColors.primary300,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  child: Text(
                    "생성하기",
                    style: EasierDodamStyles.body2,
                  ),
                  textColor: EasierDodamColors.staticWhite,
                  onPressed: () async {
                    // final isSuccess = await provider.login(
                    //   _idTextFieldController.text,
                    //   _pwTextFieldController.text,
                    // );
                    //
                    // if (isSuccess) {
                    //   Navigator.pushReplacementNamed(
                    //     context,
                    //     outRoute,
                    //   );
                    // }
                  },
                ),
              ),
              SizedBox(
                height: 8,
              )
            ],
          ),
        ),
      ),
    );
  }
}

TimeOfDay adjustTimeOfDay(TimeOfDay time, {required int hoursToAdd}) {
  // TimeOfDay를 DateTime으로 변환
  final now = DateTime.now();
  final timeAsDateTime = DateTime(
    now.year,
    now.month,
    now.day,
    time.hour,
    time.minute,
  );

  // 시간 증감
  final adjustedTimeAsDateTime =
      timeAsDateTime.add(Duration(hours: hoursToAdd));

  // 다시 TimeOfDay로 변환
  return TimeOfDay(
    hour: adjustedTimeAsDateTime.hour,
    minute: adjustedTimeAsDateTime.minute,
  );
}
