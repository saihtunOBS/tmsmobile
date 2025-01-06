import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();

  SocketService._internal();
  IO.Socket? socket;

  factory SocketService() {
    return _instance;
  }

  void connectAndListen() {
    if (socket == null) {
      socket = IO.io(
          'http://localhost:3000',
          OptionBuilder().setTransports(['websocket']).setExtraHeaders(
              {'foo': 'bar'}).build());
      socket?.onConnect((_) {
        print('connect');
        socket?.emit('msg', 'test');
      });

      socket?.on('event', (data) => print('data'));
      socket?.onDisconnect((_) => print('disconnect'));
    }
  }

  void dispose() {
    if (socket != null) {
      socket?.disconnect();
      socket = null;
    }
  }
}
