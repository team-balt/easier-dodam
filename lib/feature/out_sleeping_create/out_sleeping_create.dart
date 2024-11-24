import 'package:easier_dodam/component/preset_appbar.dart';
import 'package:easier_dodam/component/textfield.dart';
import 'package:easier_dodam/component/theme/color.dart';
import 'package:easier_dodam/component/theme/style.dart';
import 'package:easier_dodam/feature/out_sleeping_create/out_sleeping_create_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'item/out_sleeping_create_time_item.dart';

class OutSleepingCreateScreen extends StatefulWidget {
  const OutSleepingCreateScreen({super.key});

  @override
  State<OutSleepingCreateScreen> createState() =>
      _OutSleepingCreateScreenState();
}

class _OutSleepingCreateScreenState extends State<OutSleepingCreateScreen> {
  final TextEditingController _titleTextFieldController =
      TextEditingController();
  final TextEditingController _reasonTextFieldController =
      TextEditingController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 1));

  @override
  void dispose() {
    _titleTextFieldController.dispose();
    _reasonTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OutSleepingCreateViewModel(),
      child: Consumer<OutSleepingCreateViewModel>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: EasierDodamDefaultPresetAppbar(
                title: "외박 프리셋 생성하기",
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
                    const SizedBox(height: 12),
                    EasierDodamTextField(
                      labelText: "사유",
                      hintText: "외박 사유를 입력해주세요.",
                      controller: _reasonTextFieldController,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        OutSleepingCreateTimeItem(
                          title: "외박 시작",
                          date: startDate,
                          onButtonClick: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: startDate,
                              firstDate: DateTime.now(),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 365)),
                            );
                            if (date == null) return;
                            setState(() {
                              startDate = date;
                              if (!startDate.isBefore(endDate)) {
                                endDate =
                                    startDate.add(const Duration(days: 1));
                              }
                            });
                          },
                        ),
                        OutSleepingCreateTimeItem(
                          title: "외박 종료",
                          date: endDate,
                          onButtonClick: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: endDate,
                              firstDate: startDate,
                              lastDate:
                                  DateTime.now().add(const Duration(days: 365)),
                            );
                            if (date == null) return;
                            setState(() {
                              endDate = date;
                            });
                          },
                        ),
                      ],
                    ),
                    const Expanded(child: SizedBox()),
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
                          await provider.createSleeping(
                            title: _titleTextFieldController.text,
                            reason: _reasonTextFieldController.text,
                            startDate: startDate,
                            endDate: endDate,
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
}
