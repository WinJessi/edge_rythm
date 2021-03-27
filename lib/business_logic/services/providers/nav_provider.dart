import 'package:flutter/material.dart';

class NavProvider with ChangeNotifier {
  var _current = 0;
  var _topBar = 1;
  var _eventNav = 0;
  var _producerNav = 0;

  get current {
    return _current;
  }

  set current(int i) {
    _current = i;
    notifyListeners();
  }

  get topBar {
    return _topBar;
  }

  set topBar(int i) {
    _topBar = i;
    notifyListeners();
  }

  get eventNav {
    return _eventNav;
  }

  set eventNav(int i) {
    _eventNav = i;
    notifyListeners();
  }

  get producerNav {
    return _producerNav;
  }

  set producerNav(int i) {
    _producerNav = i;
    notifyListeners();
  }
}
