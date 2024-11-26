import 'package:easier_dodam/remote/core/core_client.dart';
import 'package:easier_dodam/remote/core/url.dart';
import 'package:easier_dodam/remote/out_sleeping/request/out_sleeping_request.dart';
import 'package:easier_dodam/remote/out_sleeping/response/out_sleeping_response.dart';

class OutSleepingDataSource {
  Future<bool> postOutSleeping(
    String reason,
    String startAt,
    String endAt,
  ) async {
    await CoreClient.post<void>(
      url: EasierDodamUrl.OUT_SLEEPING,
      body: OutSleepingRequest(reason: reason, startAt: startAt, endAt: endAt)
          .toJson(),
    );
    return true;
  }

  Future<List<OutSleepingResponse>> getMyOutSleeping() async {
    final response = await CoreClient.get<List<OutSleepingResponse>>(
      url: EasierDodamUrl.OUT_SLEEPING_MY,
      listDecoder: (data) {
        return data
            .map((item) =>
                OutSleepingResponse.fromJson(item as Map<String, dynamic>))
            .toList();
      },
    );

    return response.data;
  }

  Future<bool> deleteMyOutSleeping(int id) async {
    final response = await CoreClient.delete<void>(
      url: EasierDodamUrl.OUT_SLEEPING + "/$id",
    );

    print(response.message);

    return true;
  }
}
