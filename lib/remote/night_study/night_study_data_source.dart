import 'package:easier_dodam/remote/core/base_response.dart';
import 'package:easier_dodam/remote/core/core_client.dart';
import 'package:easier_dodam/remote/core/url.dart';
import 'package:easier_dodam/remote/night_study/request/night_study_request.dart';
import 'package:easier_dodam/remote/night_study/response/night_study_response.dart';

class NightStudyDataSource{

  Future<BaseResponse<NightStudyResponse>> nightStudy(
      String place,
      String content,
      bool doNeedPhone,
      String reasonForPhone,
      String startAt,
      String endAt) async {
    return await CoreClient.post(
        url: EasierDodamUrl.NIGHT_STUDY,
        body: NightStudyRequest(
            place: place,
            content: content,
            doNeedPhone: doNeedPhone,
            reasonForPhone: reasonForPhone,
            endAt: endAt,
            startAt: startAt
        ).toJson(),
        decoder: NightStudyResponse.fromJson,
        sendToken: true
    );
  }

}