import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../config/constants.dart';
import '../../models/device_model.dart';
import '../../services/accelerometer_sensor_service.dart';
import '../../services/socket_io_service.dart';
import '../../widgets/cs_appbar.dart';
import 'mouse_robot_state.dart';

class MouseRobotView extends StatefulWidget {
  const MouseRobotView({
    required this.device,
    super.key,
  });

  final DeviceModel device;

  @override
  State<MouseRobotView> createState() => _MouseRobotViewState();
}

class _MouseRobotViewState extends State<MouseRobotView> {
  late final SocketIOService socket;

  final accelerometer = AccelerometerSensorService();

  late final MouseRobotState stateView;

  @override
  void initState() {
    super.initState();

    socket = SocketIOService(widget.device.linkConnection!);

    stateView = MouseRobotState(widget.device);
    stateView.loadAcceleratorFactor();

    listenAccelerometer();
  }

  @override
  void dispose() {
    socket.dispose();
    accelerometer.dispose();

    super.dispose();
  }

  void listenAccelerometer() {
    List<double> xValues = [];
    List<double> yValues = [];
    const int bufferSize = 5;

    Timer? debouncer;
    accelerometer.accelerometerStream.listen((data) {
      if (debouncer?.isActive ?? false) return;

      if ((data.x > -1.5 && data.x < 1.5) && (data.y > -1.5 && data.y < 1.5)) return;

      if (xValues.length >= bufferSize) {
        xValues.removeAt(0);
      }
      if (yValues.length >= bufferSize) {
        yValues.removeAt(0);
      }

      xValues.add(data.x);
      yValues.add(data.y);

      double smoothedX = (xValues.reduce((a, b) => a + b) / xValues.length);
      double smoothedY = (yValues.reduce((a, b) => a + b) / yValues.length);

      double acceleratedX = smoothedX * (stateView.acceleratorFactorNegative * 0.2);
      double acceleratedY = smoothedY * (stateView.acceleratorFactorNegative * 0.2);

      debouncer = Timer(Duration(milliseconds: 20), () {
        socket.socket.emit(SocketIOEvents.MOVE, {
          'x': acceleratedX,
          'y': acceleratedY,
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CsAppbar(title: 'Mouse ${widget.device.name}'),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            StreamBuilder<bool>(
              stream: socket.connectionStatusStream,
              builder: (_, snapshot) {
                final data = snapshot.data ?? false;

                return _ConnectionStatus(
                  status: data,
                  onTap: () {
                    if (socket.isConnected()) {
                      socket.disconnect();
                      accelerometer.pause();
                    } else {
                      socket.reconnect();
                      accelerometer.resume();
                    }
                  },
                );
              },
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onPanEnd: (details) {
                if (details.velocity.pixelsPerSecond.dy > 0) {
                  socket.socket.emit(SocketIOEvents.TOUCHPAD, 'down');
                } else if (details.velocity.pixelsPerSecond.dy < 0) {
                  socket.socket.emit(SocketIOEvents.TOUCHPAD, 'up');
                }
              },
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey[700]!,
                    width: 2,
                  ),
                  color: Colors.grey,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Touchpad',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _ClickButton(
                    description: 'Clique\nEsquerdo',
                    color: theme.primaryColor,
                    onPressed: () {
                      socket.socket.emit(SocketIOEvents.CLICK, 'left');
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _ClickButton(
                    description: 'Clique\nDireito',
                    color: theme.colorScheme.secondary,
                    onPressed: () {
                      socket.socket.emit(SocketIOEvents.CLICK, 'right');
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Text('Ajuste de velocidade'),
            Row(
              children: [
                Text('1'),
                Expanded(
                  child: Observer(
                    builder: (_) {
                      return Slider(
                        value: stateView.acceleratorFactor,
                        max: 70,
                        min: 1,
                        onChanged: (value) {
                          stateView.setAcceleratorFactor(value);
                        },
                        label: stateView.acceleratorFactor.toStringAsFixed(2),
                        inactiveColor: theme.colorScheme.primaryContainer,
                      );
                    },
                  ),
                ),
                Text('70'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ClickButton extends StatelessWidget {
  const _ClickButton({
    required this.description,
    required this.color,
    required this.onPressed,
  });

  final String description;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey[700]!,
            width: 2,
          ),
          color: color,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}

class _ConnectionStatus extends StatelessWidget {
  const _ConnectionStatus({
    required this.status,
    required this.onTap,
  });

  final bool status;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey[700]!,
            width: 2,
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: status ? Colors.green : Colors.red,
              radius: 10,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(status ? 'Conectado' : 'Desconectado'),
                Text(
                  'Clique para se ${status ? 'desconectar' : 'conectar'}',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
