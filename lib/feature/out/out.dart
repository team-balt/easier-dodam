import 'package:easier_dodam/component/appbar.dart';
import 'package:easier_dodam/component/modal_bottom_sheet_container.dart';
import 'package:easier_dodam/component/theme/color.dart';
import 'package:easier_dodam/component/theme/style.dart';
import 'package:easier_dodam/feature/out/item/out_item.dart';
import 'package:easier_dodam/feature/out/out_viewmodel.dart';
import 'package:easier_dodam/feature/out_create/out_create_navigation.dart';
import 'package:easier_dodam/remote/out/response/out_response.dart';
import 'package:easier_dodam/utiles/utile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'item/out_preset_item.dart';

class OutScreen extends StatefulWidget {
  const OutScreen({super.key});

  @override
  State<OutScreen> createState() => _OutScreenState();
}

class _OutScreenState extends State<OutScreen> with WidgetsBindingObserver {
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
                          "현재 신청된 외출",
                          style: EasierDodamStyles.body1,
                        ),
                        ...viewModel.outResponses
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
                                        viewModel.deleteMyOut(item.id);
                                      },
                                      startAt: item.startAt.timeOfDay,
                                      endAt: item.endAt.timeOfDay,
                                    ),
                                  ],
                                ))
                            .toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
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
