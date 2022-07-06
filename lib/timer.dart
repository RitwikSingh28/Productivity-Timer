import 'timer_model.dart';
import 'dart:async';

class CountDownTimer {
  double _radius = 1;
  bool _isActive = true;
  Timer? timer;
  Duration? _time;
  Duration? _fullTime;

  int workTime = 15;
  int shortBreak = 5;
  int longBreak = 15;

  void startWork() {
    _isActive = true;
    _time = Duration(minutes: workTime, seconds: 0);
    _fullTime = _time;
  }

  void startBreak(bool isShort) {
    _isActive = true;
    _time = Duration(minutes: (isShort) ? shortBreak : longBreak, seconds: 0);
    _fullTime = _time;
  }

  void stopTimer() {
    _isActive = false;
  }

  void startTimer() {
    if (_time!.inSeconds > 0) {
      _isActive = true;
    }
  }

  String returnTime(Duration t) {
    String minutes =
        (t.inMinutes < 10) ? '0${t.inMinutes}' : t.inMinutes.toString();
    int word = t.inSeconds - (t.inMinutes * 60);
    String seconds = (word < 10) ? '0$word' : word.toString();
    String format = "$minutes:$seconds";
    return format;
  }

  Stream<TimerModel> stream() async* {
    yield* Stream.periodic(const Duration(seconds: 1), (int a) {
      String time;
      if (_isActive) {
        _time = _time! - const Duration(seconds: 1);
        _radius = _time!.inSeconds / _fullTime!.inSeconds;
        if (_time!.inSeconds <= 0) {
          _isActive = false;
        }
      }
      time = returnTime(_time!);
      return TimerModel(_radius, time);
    });
  }
}
