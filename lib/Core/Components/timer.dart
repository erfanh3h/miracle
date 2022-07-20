import 'dart:async';

import 'package:get/get.dart';

import 'date_actions.dart';

class TimerCompanent extends GetxController {
  Timer? _timer;
  final RxInt _start = RxInt(300);
  RxString timerLabel = RxString('');

  void startTimer(int? timerDuration) {
    pauseTimer();

    _start.value = timerDuration ?? 300;

    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start < 1) {
          timer.cancel();
        } else {
          _start.value = _start.value - 1;
          timerLabel.value =
              DateActionsComponent.formatSecondsToMinutes(_start.value);
        }
      },
    );
  }

  void pauseTimer() {
    if (_timer != null) _timer!.cancel();
  }

  void stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _start.value = 300;
      timerLabel.value =
          DateActionsComponent.formatSecondsToMinutes(_start.value);
    }
  }

  void unpauseTimer() => startTimer(_start.value);

  @override
  void dispose() {
    try {
      _timer!.cancel();
    } catch (_) {}
    super.dispose();
  }
}
