import 'package:flutter/material.dart';

class NavProvider with ChangeNotifier {
  var _current = 0;

  get current {
    return _current;
  }

  set current(int i) {
    _current = i;
    notifyListeners();
  }
}
