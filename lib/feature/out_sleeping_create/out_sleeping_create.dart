import 'package:easier_dodam/component/preset_appbar.dart';
import 'package:easier_dodam/component/textfield.dart';
import 'package:easier_dodam/component/theme/color.dart';
import 'package:easier_dodam/component/theme/style.dart';
import 'package:easier_dodam/feature/out_sleeping_create/out_sleeping_create_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
  final TextEditingController _durationTextFieldController =
      TextEditingController();

  @override
  void dispose() {
    _titleTextFieldController.dispose();
    _reasonTextFieldController.dispose();
    _durationTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OutSleepingCreateViewModel(),
      child: Consumer<OutSleepingCreateViewModel>(
        builder: (context, provider, child) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
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
                child: ListView(
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
                    EasierDodamTextField(
                      labelText: "외박 기간 (일)",
                      hintText: "외박 기간을 입력해주세요.",
                      controller: _durationTextFieldController,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 150,
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                          final title = _titleTextFieldController.text;
                          final reason = _reasonTextFieldController.text;
                          final durationText =
                              _durationTextFieldController.text;

                          if (title.isEmpty ||
                              reason.isEmpty ||
                              durationText.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("모든 필드를 입력해주세요."),
                              ),
                            );
                            return;
                          }

                          final duration = int.tryParse(durationText);
                          if (duration == null || duration <= 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("올바른 외박 기간(일)을 입력해주세요."),
                              ),
                            );
                            return;
                          }
                          final dateFormatter = DateFormat('yyyy-MM-dd');
                          final startDate = DateTime.now();
                          final endDate =
                              startDate.add(Duration(days: duration));

                          final startDateString =
                              dateFormatter.format(startDate);
                          final endDateString = dateFormatter.format(endDate);

                          await provider.createSleeping(
                            title: title,
                            reason: reason,
                            startDate: startDateString,
                            endDate: endDateString,
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
