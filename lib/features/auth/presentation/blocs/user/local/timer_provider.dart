import 'dart:async';

import 'package:flutter/foundation.dart';

class TimerProvider extends ChangeNotifier {
  int _minute = 04;
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

            if (_minute == 0 && _second == 0) {
              timer.cancel();
              _minute = 04;
               _second = 60;
              _isrunning = !_isrunning;
              notifyListeners();
            } else if (_second == 00) {
              _second = 60;
              _minute--;
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
