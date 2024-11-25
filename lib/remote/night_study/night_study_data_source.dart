import 'package:easier_dodam/remote/core/base_response.dart';
import 'package:easier_dodam/remote/core/core_client.dart';
import 'package:easier_dodam/remote/core/url.dart';
import 'package:easier_dodam/remote/night_study/request/night_study_request.dart';
import 'package:easier_dodam/remote/night_study/response/night_study_response.dart';

import '../../feature/night_study/item/night_study_item.dart';

class NightStudyDataSource{

  Future<BaseResponse<NightStudyResponse>> postNightStudy(
      String title,
      String reason,
      PlaceType place,
      String content,
      bool doNeedPhone,
      String reasonForPhone,
      DateTime startAt,
      DateTime endAt) async {
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

  Future<List<NightStudyResponse>> getMyNightStudies() async{
    final response = await CoreClient.get<List<NightStudyResponse>>(
        url: EasierDodamUrl.NIGHT_STUDY,
        listDecoder: (data) {
      return data
          .map((item) => NightStudyResponse.fromJson(item as Map<String, dynamic>))
          .toList();
      },
    );
    return response.data;
    }

  Future<bool> deleteMyNightStudy(int id) async {
    final response = await CoreClient.delete<void>(
      url: EasierDodamUrl.NIGHT_STUDY + "/$id",
    );

    print(response.message);

    return true;
  }

}