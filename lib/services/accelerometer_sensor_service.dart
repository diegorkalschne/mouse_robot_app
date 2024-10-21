import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';

class AccelerometerSensorService {
  AccelerometerSensorService() {
    init();
  }

  final StreamController<AccelerometerEvent> _controller = StreamController<AccelerometerEvent>.broadcast();
  late final StreamSubscription _stream;

  void init() {
    _stream = accelerometerEventStream().listen((data) {
      if (!_controller.isClosed) {
        _controller.add(data);
      }
    });
  }

  Stream<AccelerometerEvent> get accelerometerStream => _controller.stream;

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
