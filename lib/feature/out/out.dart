import 'package:easier_dodam/component/appbar.dart';
import 'package:easier_dodam/component/modal_bottom_sheet_container.dart';
import 'package:easier_dodam/component/theme/color.dart';
import 'package:easier_dodam/component/theme/style.dart';
import 'package:easier_dodam/feature/night_study/night_study_navigation.dart';
import 'package:easier_dodam/feature/out/item/out_item.dart';
import 'package:easier_dodam/feature/out/out_navigation.dart';
import 'package:easier_dodam/feature/out/out_viewmodel.dart';
import 'package:easier_dodam/feature/out_create/out_create_navigation.dart';
import 'package:easier_dodam/remote/out/response/out_response.dart';
import 'package:easier_dodam/utiles/utile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../component/bottom_navigation_bar.dart';
import '../logout/logout_navigation.dart';
import '../out_sleeping/out_sleeping_navigation.dart';
import 'item/out_preset_item.dart';

class OutScreen extends StatefulWidget {
  const OutScreen({super.key});

  @override
  State<OutScreen> createState() => _OutScreenState();
}

class _OutScreenState extends State<OutScreen> with WidgetsBindingObserver {

  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

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
      final viewModel = Provider.of<OutViewModel>(context, listen: false);
      viewModel.getMyOuts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OutViewModel>(
      builder: (BuildContext context, OutViewModel viewModel, Widget? child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: EasierDodamDefaultAppbar(
              title: "외출",
              onPlusClick: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return ChangeNotifierProvider.value(
                      value: viewModel,
                      child: Consumer<OutViewModel>(
                        builder: (
                          BuildContext context,
                          OutViewModel value,
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
                return viewModel.getMyOuts();
              },
              color: EasierDodamColors.primary300,
              backgroundColor: EasierDodamColors.staticWhite,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListView(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          viewModel.isLoading ? "" : "현재 신청된 외출",
                          style: EasierDodamStyles.body1,
                        ),
                        _loading(viewModel.isLoading),
                        _notExitsOut(
                          viewModel.outResponses.isEmpty &&
                              !viewModel.isLoading,
                          () {
                            viewModel.getMyOuts();
                          },
                        ),
                        ..._outItemsView(
                          viewModel.outResponses,
                          viewModel.isLoading,
                          (item) => {viewModel.deleteMyOut(item.id)},
                        ),
                      ],
                    ),
                  ),
                ],
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
      },
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

  Widget _notExitsOut(bool isExit, Function() onClick) {
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
              offset: const Offset(0, 4), // changes position of shadow
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
                "현재 신청된 외출이 없어요",
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

  List<Widget> _outItemsView(
    List<OutResponse> items,
    bool isLoading,
    Function(OutResponse) onClickTrash,
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
                OutItem(
                  tagType: switch (item.status) {
                    OutStatus.ALLOWED => TagType.APPROVE,
                    OutStatus.PENDING => TagType.PENDING,
                    OutStatus.REJECTED => TagType.REJECT,
                  },
                  onClickTrash: () {
                    onClickTrash(item);
                  },
                  startAt: item.startAt.timeOfDay,
                  endAt: item.endAt.timeOfDay,
                ),
              ],
            ))
        .toList();
  }

  Widget _bottomSheet(BuildContext context, OutViewModel viewModel) {
    return ModalBottomSheetContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "외출 신청하기",
                  style: EasierDodamStyles.title1,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              ...viewModel.outEntities
                  .map(
                    (data) => OutPresetItem(
                      title: data.title,
                      reason: data.reason,
                      startAt: "${data.startAt.hour}시 ${data.startAt.minute}분",
                      endAt: "${data.endAt.hour}시 ${data.endAt.minute}분",
                      onTrashClick: () {
                        viewModel.removeEntity(data.id ?? 0);
                      },
                      onClick: () async {
                        Navigator.pop(context);
                        await viewModel.requestOut(data);
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
                color: EasierDodamColors.staticWhite,
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      outCreateRoute,
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
