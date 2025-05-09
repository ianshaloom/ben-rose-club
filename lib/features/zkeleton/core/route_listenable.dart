import 'package:flutter/widgets.dart';

class RouterListenable extends ChangeNotifier{
  void notify() {
    notifyListeners();
  }
}