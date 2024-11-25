import 'package:easier_dodam/component/appbar.dart';
import 'package:easier_dodam/component/bottom_navigation_bar.dart';
import 'package:easier_dodam/component/modal_bottom_sheet_container.dart';
import 'package:easier_dodam/component/theme/color.dart';
import 'package:easier_dodam/component/theme/style.dart';
import 'package:easier_dodam/feature/night_study/item/night_study_preset_item.dart';
import 'package:easier_dodam/feature/night_study/night_study_create/night_study_create_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'night_study_viewmodel.dart';

class NightStudyScreen extends StatefulWidget {
  const NightStudyScreen({super.key});

  @override
  State<NightStudyScreen> createState() => _NightStudyScreenState();
}

class _NightStudyScreenState extends State<NightStudyScreen> {
  final TextEditingController _reasonTextFieldController =
      TextEditingController();

  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPlusClick(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ChangeNotifierProvider.value(
          value: NightStudyViewmodel(),
          child: Consumer<NightStudyViewmodel>(
            builder: (
              BuildContext context,
              NightStudyViewmodel value,
              Widget? child,
            ) {
              return _bottomWidget(context, NightStudyViewmodel());
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _reasonTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NightStudyViewmodel>(builder:
        (BuildContext context, NightStudyViewmodel viewModel, Widget? child) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: EasierDodamDefaultAppbar(
            title: '심자',
            onPlusClick: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ChangeNotifierProvider.value(
                    value: viewModel,
                    child: Consumer<NightStudyViewmodel>(
                      builder: (
                          BuildContext context,
                          NightStudyViewmodel value,
                          Widget? child,
                          ) {
                        return _bottomWidget(context, viewModel);
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
        body: SafeArea(
          child: ChangeNotifierProvider(
            create: (_) => NightStudyViewmodel(),
            child: Consumer<NightStudyViewmodel>(
              builder: (context, provider, child) {
                return Container(
                  color: EasierDodamColors.staticWhite,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "현재 신청된 심자",
                        style: EasierDodamStyles.body1,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: 12,
                        width: double.infinity,
                      ),
                      Container(
                        //프레임 시작
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        decoration: BoxDecoration(
                            color: EasierDodamColors.staticWhite,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: Offset(0, 4),
                              )
                            ]),
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        height: 106,
                        width: 380,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 8,
                              width: 12,
                            ),
                            Container(
                              //수락됨
                              height: 24,
                              width: 52,
                              alignment: Alignment.center,
                              child: Text("수락됨",
                                  style: EasierDodamStyles.label1
                                      .copyWith(
                                          color: EasierDodamColors.staticWhite)
                                      .copyWith(fontSize: 12)),
                              decoration: BoxDecoration(
                                color: EasierDodamColors.primary300,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: EasierDodamBottomNavigationBar(
            selectedIndex: _selectedIndex,
            onItemTapped: _onItemTapped,
          ),
        ),
      );
    });
  }

  Widget _bottomWidget(BuildContext context, NightStudyViewmodel viewModel) {
    return ModalBottomSheetContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 44,
                width: 380,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: Text("심자 신청하기", style: EasierDodamStyles.title1),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              ...viewModel.nightStudyEntities
                  .map(
                    (data) => NightStudyPresetItem(
                      presetTitle: data.title,
                      reason: data.reason,
                      place: data.place,
                      doNeedPhone: data.doNeedPhone,
                      phoneReason: data.reasonForPhone,
                      startDate: "${data.startAt} ${data.startAt.minute}",
                      endDate: "${data.endAt.hour} ${data.endAt.minute}",
                      onTrashClick: () {
                        viewModel.removeEntity(data.id ?? 0);
                        },
                      onClickCreate: () async {
                        Navigator.pop(context);
                        await viewModel.nightStudy(data);
                        },
                    ),
              )
                  .toList(),
              SizedBox(
                height: 8,
              ),
              Divider(
                height: 1,
                color: EasierDodamColors.gray600,
              ),
              SizedBox(
                height: 8,
              ),
              Material( //프리셋 생성 시작
                color: EasierDodamColors.staticWhite,
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      nightStudyCreateRoute,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          width: 24,
                          height: 24,
                          "assets/images/ic_plus.png",
                          color: EasierDodamColors.gray700,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "새로운 프리셋 만들기",
                          style: EasierDodamStyles.body2,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

