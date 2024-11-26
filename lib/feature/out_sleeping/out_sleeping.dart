import 'package:easier_dodam/component/appbar.dart';
import 'package:easier_dodam/component/modal_bottom_sheet_container.dart';
import 'package:easier_dodam/component/theme/color.dart';
import 'package:easier_dodam/component/theme/style.dart';
import 'package:easier_dodam/feature/logout/logout_navigation.dart';
import 'package:easier_dodam/feature/night_study/night_study_navigation.dart';
import 'package:easier_dodam/feature/out_sleeping/item/out_sleeping_item.dart';
import 'package:easier_dodam/feature/out_sleeping/out_sleeping_navigation.dart';
import 'package:easier_dodam/feature/out_sleeping/out_sleeping_viewmodel.dart';
import 'package:easier_dodam/feature/out_sleeping_create/out_sleeping_create_navigation.dart';
import 'package:easier_dodam/remote/out_sleeping/response/out_sleeping_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../component/bottom_navigation_bar.dart';
import '../out/out_navigation.dart';

String formatDateWithDay(DateTime date) {
  const weekDays = ["월", "화", "수", "목", "금", "토", "일"];
  return DateFormat('yy.MM.dd').format(date) +
      "(${weekDays[date.weekday - 1]})";
}

class OutSleepingScreen extends StatefulWidget {
  const OutSleepingScreen({super.key});

  @override
  State<OutSleepingScreen> createState() => _OutSleepingScreenState();
}

class _OutSleepingScreenState extends State<OutSleepingScreen>
    with WidgetsBindingObserver {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

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
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      final viewModel =
          Provider.of<OutSleepingViewModel>(context, listen: false);
      viewModel.getMySleepings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OutSleepingViewModel>(
      builder: (BuildContext context, OutSleepingViewModel viewModel,
          Widget? child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: EasierDodamDefaultAppbar(
              title: "외박",
              onPlusClick: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return ChangeNotifierProvider.value(
                      value: viewModel,
                      child: Consumer<OutSleepingViewModel>(
                        builder: (
                          BuildContext context,
                          OutSleepingViewModel value,
                          Widget? child,
                        ) {
                          return _bottomSheet(context, viewModel);
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
                return viewModel.getMySleepings();
              },
              color: EasierDodamColors.primary300,
              backgroundColor: EasierDodamColors.staticWhite,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListView(
                      children: [
                        Text(
                          viewModel.isLoading ? "" : "현재 신청된 외박",
                          style: EasierDodamStyles.body1,
                        ),
                        _loading(viewModel.isLoading),
                        _notExitsSleeping(
                          viewModel.sleepingResponses.isEmpty &&
                              !viewModel.isLoading,
                          () {
                            viewModel.getMySleepings();
                          },
                        ),
                        ..._sleepingItemsView(
                          viewModel.sleepingResponses,
                          viewModel.isLoading,
                          (item) => {viewModel.deleteMySleeping(item.id)},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: EasierDodamBottomNavigationBar(
            selectedIndex: _selectedIndex,
            onItemTapped: _onItemTapped,
          ),
        );
      },
    );
  }

  Widget _loading(bool isLoading) {
    if (isLoading) {
      return Center(
        child: SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            backgroundColor: EasierDodamColors.staticWhite,
            color: EasierDodamColors.primary300,
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _notExitsSleeping(bool isExit, Function() onClick) {
    if (isExit) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
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
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: Image.asset("assets/images/ic_happy.png"),
              ),
              const SizedBox(height: 12),
              Text(
                "현재 신청된 외박이 없어요",
                style: EasierDodamStyles.label1,
              ),
              const SizedBox(height: 12),
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
                          width: 1.0,
                          color: EasierDodamColors.gray500,
                        ),
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
      return const SizedBox();
    }
  }

  List<Widget> _sleepingItemsView(
    List<OutSleepingResponse> items,
    bool isLoading,
    Function(OutSleepingResponse) onClickTrash,
  ) {
    if (isLoading) {
      return List.empty();
    }
    return items.map((item) {
      // DateTime 변환
      DateTime? startAt = DateTime.tryParse(item.startAt.toString());
      DateTime? endAt = DateTime.tryParse(item.endAt.toString());

      return Column(
        children: [
          const SizedBox(height: 12),
          OutSleepingItem(
            tagType: switch (item.status) {
              OutSleepingStatus.ALLOWED => TagType.APPROVE,
              OutSleepingStatus.PENDING => TagType.PENDING,
              OutSleepingStatus.REJECTED => TagType.REJECT,
            },
            onClickTrash: () {
              onClickTrash(item);
            },
            startAt: startAt ?? DateTime.now(),
            endAt: endAt ?? DateTime.now(),
          ),
        ],
      );
    }).toList();
  }

  Widget _bottomSheet(BuildContext context, OutSleepingViewModel viewModel) {
    return ModalBottomSheetContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "외박 신청하기",
                  style: EasierDodamStyles.title1,
                ),
              ),
              const SizedBox(height: 8),
              ...viewModel.sleepingEntities.map(
                (data) {
                  // DateTime 변환
                  DateTime? startAt =
                      DateTime.tryParse(data.startAt.toString());
                  DateTime? endAt = DateTime.tryParse(data.endAt.toString());

                  return OutSleepingPresetItem(
                    title: data.title,
                    reason: data.reason,
                    startAt: startAt ?? DateTime.now(),
                    endAt: endAt ?? DateTime.now(),
                    onTrashClick: () {
                      viewModel.removeEntity(data.id ?? 0);
                    },
                    onClick: () async {
                      Navigator.pop(context);
                      await viewModel.requestSleeping(data);
                    },
                  );
                },
              ),
              const SizedBox(height: 8),
              const Divider(height: 1, color: EasierDodamColors.gray600),
              const SizedBox(height: 8),
              Material(
                color: EasierDodamColors.staticWhite,
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      outSleepingCreateRoute,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Image.asset(
                            "assets/images/ic_plus.png",
                            color: EasierDodamColors.gray700,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "새로운 프리셋 만들기",
                          style: EasierDodamStyles.body2,
                        ),
                      ],
                    ),
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
