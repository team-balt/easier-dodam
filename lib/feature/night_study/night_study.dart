import 'package:easier_dodam/component/appbar.dart';
import 'package:easier_dodam/component/bottom_navigation_bar.dart';
import 'package:easier_dodam/component/modal_bottom_sheet_container.dart';
import 'package:easier_dodam/component/theme/color.dart';
import 'package:easier_dodam/component/theme/style.dart';
import 'package:easier_dodam/feature/night_study/item/night_study_item.dart';
import 'package:easier_dodam/feature/night_study/item/night_study_preset_item.dart';
import 'package:easier_dodam/remote/night_study/response/night_study_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../logout/logout_navigation.dart';
import '../night_study_create/night_study_create_navigation.dart';
import '../out/out_navigation.dart';
import '../out_sleeping/out_sleeping_navigation.dart';
import 'night_study_navigation.dart';
import 'night_study_viewmodel.dart';

class NightStudyScreen extends StatefulWidget {
  const NightStudyScreen({super.key});

  @override
  State<NightStudyScreen> createState() => _NightStudyScreenState();
}

class _NightStudyScreenState extends State<NightStudyScreen> {
  final TextEditingController _reasonTextFieldController =
      TextEditingController();

  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, outSleepingRoute);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, outRoute);
        break;
      case 2:
        Navigator.pushReplacementNamed(context, nightStudyRoute);
        break;
      case 3:
        Navigator.pushReplacementNamed(context, logoutRoute);
        break;
    }
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
          child: RefreshIndicator(
            onRefresh: () async {
              return viewModel.getMyNightStudies();
            },
            child: Consumer<NightStudyViewmodel>(
              builder: (context, provider, child) {
                return Container(
                  color: EasierDodamColors.staticWhite,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        viewModel.isLoading ? "" : "현재 신청된 심자",
                        style: EasierDodamStyles.body1,
                        textAlign: TextAlign.start,
                      ),
                      _loading(viewModel.isLoading),
                      _notExitsNightStudy(
                        viewModel.nightStudyResponses.isEmpty &&
                            !viewModel.isLoading,
                        () {
                          viewModel.getMyNightStudies();
                        },
                      ),
                      ..._nightStudyItemsView(
                        viewModel.nightStudyResponses,
                        viewModel.isLoading, 
                            (item) => {
                          viewModel.deleteMyOut(item.id)
                            },
                      ),
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
                      place: data.place,
                      content: data.content,
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
              Material(
                //프리셋 생성 시작
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

  Widget _loading(bool isLoading) {
    if (isLoading) {
      return Center(
        child: Container(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            backgroundColor: EasierDodamColors.staticWhite,
            color: EasierDodamColors.primary300,
          ),
        ),
      );
    } else {
      return SizedBox();
    }
  }

  Widget _notExitsNightStudy(bool isExit, Function() onClick) {
    if (isExit) {
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: Image.asset("assets/images/ic_happy.png"),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                "현재 신청된 심자가 없어요",
                style: EasierDodamStyles.label1,
              ),
              SizedBox(
                height: 12,
              ),
              Material(
                color: EasierDodamColors.staticWhite,
                child: InkWell(
                  onTap: onClick,
                  child: Container(
                    width: double.infinity,
                    height: 42,
                    decoration: BoxDecoration(
                      border: const Border.fromBorderSide(
                        BorderSide(
                            width: 1.0, color: EasierDodamColors.gray500),
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        "새로고침",
                        style: EasierDodamStyles.label1,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return SizedBox();
    }
  }

  List<Widget> _nightStudyItemsView(
    List<NightStudyResponse> items,
    bool isLoading,
    Function(NightStudyResponse) onClickTrash,
  ) {
    if (isLoading) {
      return List.empty();
    }
    return items
        .map((item) => Column(
              children: [
                SizedBox(
                  height: 12,
                ),
                NightStudyItem(
                  tagType: switch (item.status) {
                    Status.ALLOWED => TagType.APPROVE,
                    Status.PENDING => TagType.PENDING,
                    Status.REJECTED => TagType.REJECT,
                  },
                  onClickTrash: () {
                    onClickTrash(item);
                  },
                  startAt: item.startAt,
                  endAt: item.endAt,
                ),
              ],
            ))
        .toList();
  }
}
