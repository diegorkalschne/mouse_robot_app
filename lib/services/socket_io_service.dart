import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketIOService {
  SocketIOService(String url) {
    _initializeSocket(url);
  }

  late final io.Socket socket;
  late final StreamController<bool> _connectionStatusController;

  Stream<bool> get connectionStatusStream => _connectionStatusController.stream;

  void _initializeSocket(String url) {
    socket = io.io(
      url,
      io.OptionBuilder().setTransports(['websocket']).setReconnectionAttempts(5).setReconnectionDelay(1000).build(),
    );

    _connectionStatusController = StreamController<bool>.broadcast();

    socket.onConnect((_) {
      if (!_connectionStatusController.isClosed) {
        _connectionStatusController.add(true);
      }
    });

    socket.onDisconnect((_) {
      if (!_connectionStatusController.isClosed) {
        _connectionStatusController.add(false);
      }
    });
  }

  void reconnect() {
    if (!socket.connected) {
      socket.connect();
    }
  }

  void disconnect() {
    if (socket.connected) {
      socket.disconnect();
    }
  }

  bool isConnected() {
    return socket.connected;
  }

  void dispose() {
    _connectionStatusController.close();
    disconnect();
  }
}
