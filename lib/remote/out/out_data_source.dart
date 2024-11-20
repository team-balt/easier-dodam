import 'package:easier_dodam/remote/core/core_client.dart';
import 'package:easier_dodam/remote/core/url.dart';
import 'package:easier_dodam/remote/out/request/out_request.dart';
import 'package:easier_dodam/remote/out/response/out_response.dart';

class OutDataSource {
  Future<bool> postOut(
    String reason,
    DateTime startAt,
    DateTime endAt,
  ) async {
    await CoreClient.post<void>(
      url: EasierDodamUrl.OUT_GOING,
      body: OutRequest(reason: reason, startAt: startAt, endAt: endAt).toJson(),
    );
    return true;
  }

  Future<List<OutResponse>> getMyOuts() async {
    final response = await CoreClient.get<List<OutResponse>>(
      url: EasierDodamUrl.OUT_GOING_MY,
      listDecoder: (data) {
        return data
            .map((item) => OutResponse.fromJson(item as Map<String, dynamic>))
            .toList();
      },
    );

    return response.data;
  }

  Future<bool> deleteMyOut(int id) async {
    final response = await CoreClient.delete<void>(
      url: EasierDodamUrl.OUT_GOING + "/$id",
    );

    print(response.message);

    return true;
  }
}
