import 'package:flutter/cupertino.dart';

import '../../local/storage_manager.dart';

class SettingViewModel with ChangeNotifier {
  Future<bool> logout() async {
    await StorageManager.deleteUserAccount();
    notifyListeners();
    return true;
  }
}
