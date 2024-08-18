import 'package:flutter/material.dart';

class UiState extends ChangeNotifier {
  int _indexSelected = 1;

  int get indexSelected {
    return _indexSelected;
  }

  set indexSelected(int index) {
    _indexSelected = index;
    notifyListeners();
  }
}
