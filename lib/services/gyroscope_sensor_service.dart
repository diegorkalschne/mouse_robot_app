import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';

class GyroscopeSensorService {
  GyroscopeSensorService() {
    init();
  }

  final StreamController<GyroscopeEvent> _controller = StreamController<GyroscopeEvent>.broadcast();
  late final StreamSubscription _stream;

  void init() {
    _stream = gyroscopeEventStream().listen((data) {
      if (!_controller.isClosed) {
        _controller.add(data);
      }
    });
  }

  Stream<GyroscopeEvent> get gyroscopeStream => _controller.stream;

  void pause() {
    if (!_stream.isPaused) {
      _stream.pause();
    }
  }

  void resume() {
    if (_stream.isPaused) {
      _stream.resume();
    }
  }

  void dispose() {
    _stream.cancel();
    _controller.close();
  }
}
