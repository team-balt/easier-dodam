import 'package:easier_dodam/remote/core/core_client.dart';
import 'package:easier_dodam/remote/core/url.dart';
import 'package:easier_dodam/remote/out/request/out_request.dart';

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
}
