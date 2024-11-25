import 'package:easier_dodam/feature/night_study/night_study_create/night_study_create_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../component/preset_appbar.dart';
import '../../../component/textfield.dart';
import '../../../component/theme/color.dart';
import '../../../component/theme/style.dart';
import '../item/night_study_item.dart';
import '../item/night_study_present_item.dart';
import 'item/night_study_create_time_item.dart';

class NightStudyCreateScreen extends StatefulWidget {
  const NightStudyCreateScreen({super.key});

  @override
  State<NightStudyCreateScreen> createState() => _NightStudyCreateState();
}

class _NightStudyCreateState extends State<NightStudyCreateScreen> {
  final TextEditingController _titleTextFieldController = TextEditingController();
  final TextEditingController _contentTextFieldController = TextEditingController();
  final TextEditingController _reasonTextFieldController = TextEditingController();

  TimeOfDay startAt = TimeOfDay.now();
  TimeOfDay endAt = adjustTimeOfDay(TimeOfDay.now(), hoursToAdd: 3);

  PlaceType? selectedPlace;
  bool doNeedPhone = false;

  @override
  void dispose() {
    _titleTextFieldController.dispose();
    _contentTextFieldController.dispose();
    _reasonTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NightStudyCreateViewModel(),
      child: Consumer<NightStudyCreateViewModel>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: EasierDodamDefaultPresetAppbar(
                title: "심자 프리셋 생성하기",
                onLeftArrowClick: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    EasierDodamTextField(
                      labelText: "프리셋 제목",
                      hintText: "프리셋 제목을 입력해주세요.",
                      controller: _titleTextFieldController,
                    ),
                    const SizedBox(height: 12),
                    EasierDodamTextField(
                      labelText: "사유",
                      hintText: "사유를 입력해주세요.",
                      controller: _contentTextFieldController,
                    ),
                    const SizedBox(height: 12),
                    DropdownButton<PlaceType>(
                      value: selectedPlace,
                      hint: const Text("장소를 선택하세요"),
                      items: PlaceType.values.map((place) {
                        return DropdownMenuItem(
                          value: place,
                          child: Text(place.name),
                        );
                      }).toList(),
                      onChanged: (PlaceType? value) {
                        setState(() {
                          selectedPlace = value;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("휴대폰 필요 여부", style: TextStyle(fontSize: 16)),
                        Switch(
                          value: doNeedPhone,
                          onChanged: (value) {
                            setState(() {
                              doNeedPhone = value;
                              if (!doNeedPhone) {
                                _reasonTextFieldController.clear();
                              }
                            });
                          },
                        ),
                      ],
                    ),
                    if (doNeedPhone)
                      EasierDodamTextField(
                        labelText: "휴대폰 필요 사유",
                        hintText: "휴대폰이 필요한 이유를 입력해주세요.",
                        controller: _reasonTextFieldController,
                      ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        NightStudyCreateTimeItem(
                          title: "심자 시작",
                          buttonText: "${startAt.hour}시 ${startAt.minute}분",
                          onButtonClick: () async {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: startAt,
                            );
                            if (time != null) {
                              final diffMin = timeOfDayDifference(time, endAt);
                              setState(() {
                                startAt = time;
                                if (diffMin < 0) {
                                  endAt = time;
                                }
                              });
                            }
                          },
                        ),
                        NightStudyCreateTimeItem(
                          title: "심자 종료",
                          buttonText: "${endAt.hour}시 ${endAt.minute}분",
                          onButtonClick: () async {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: endAt,
                            );
                            if (time != null) {
                              setState(() {
                                endAt = time;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      height: 56.0,
                      child: MaterialButton(
                        height: 56.0,
                        color: EasierDodamColors.primary300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: const Text(
                          "생성하기",
                          style: EasierDodamStyles.body2,
                        ),
                        textColor: EasierDodamColors.staticWhite,
                        onPressed: () async {
                          if (selectedPlace == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("장소를 선택해주세요.")),
                            );
                            return;
                          }
                          if (doNeedPhone && _reasonTextFieldController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("휴대폰 필요 사유를 입력해주세요.")),
                            );
                            return;
                          }
                          await provider.createNightStudy(
                            place: selectedPlace!,
                            content: _contentTextFieldController.text,
                            doNeedPhone: doNeedPhone,
                            reasonForPhone: _reasonTextFieldController.text,
                            startAt: startAt,
                            endAt: endAt,
                          );
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  static TimeOfDay adjustTimeOfDay(TimeOfDay time, {required int hoursToAdd}) {
    final now = DateTime.now();
    final timeAsDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    final adjustedTimeAsDateTime = timeAsDateTime.add(Duration(hours: hoursToAdd));

    return TimeOfDay(
      hour: adjustedTimeAsDateTime.hour,
      minute: adjustedTimeAsDateTime.minute,
    );
  }

  static int timeOfDayDifference(TimeOfDay start, TimeOfDay end) {
    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;
    return endMinutes - startMinutes;
  }
}