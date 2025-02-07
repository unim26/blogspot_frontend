import 'dart:async';

import 'package:flutter/foundation.dart';

class TimerProvider extends ChangeNotifier {
  int _minute = 05;
  int _second = 60;
  bool _isrunning = false;

  int get minute => _minute;
  int get second => _second;
  bool get isrunning => _isrunning;

  //start
  void start() {
    _isrunning = !_isrunning;

    if (isrunning) {
      Timer.periodic(
        Duration(seconds: 1),
        (timer) {
          //start stop
          if (isrunning) {
            _second--;

            if (_second == 00) {
              _second = 60;
              _minute--;
              notifyListeners();
            } else if (_minute == 00) {
              timer.cancel();
              _isrunning = !_isrunning;
              notifyListeners();
            }

            notifyListeners();
          } else {
            timer.cancel();
            notifyListeners();
          }
        },
      );
    }
  }
}
