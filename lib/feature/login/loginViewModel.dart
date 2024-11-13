import 'dart:io';

import 'package:flutter/material.dart';

class LoginViewModel with ChangeNotifier {
  String _testState = "asd";
  String get testState => _testState;

  LoginViewModel() {
    testSet();
  }

  Future<void> testSet() async {
    await Future.delayed(const Duration(seconds: 1));
    _testState = "qwe";
    notifyListeners();
  }
}
