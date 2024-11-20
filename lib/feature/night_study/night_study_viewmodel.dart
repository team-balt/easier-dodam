import 'package:easier_dodam/remote/night_study/night_study_data_source.dart';
import 'package:easier_dodam/remote/night_study/response/night_study_response.dart';
import 'package:flutter/cupertino.dart';

import '../../remote/core/base_response.dart';

class NightStudyViewmodel with ChangeNotifier{
  late NightStudyDataSource _nightStudyDataSource;

  String _testState = "";
  String get testState => _testState;

  NightStudyViewmodel(){
    _nightStudyDataSource = NightStudyDataSource();
  }

  Future<bool> nightStudy(
      String place,
      String content,
      bool doNeedPhone,
      String reasonForPhone,
      String startAt,
      String endAt
      ) async {
    final BaseResponse<NightStudyResponse> response =
        await _nightStudyDataSource.nightStudy(place, content, doNeedPhone, reasonForPhone, startAt, endAt);
    notifyListeners();
    return true;
  }


}