import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final int mililiseconds;
  Timer _timer;
  VoidCallback action;

  Debouncer({this.mililiseconds});
  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = new Timer(Duration(milliseconds: mililiseconds), action);
  }
}