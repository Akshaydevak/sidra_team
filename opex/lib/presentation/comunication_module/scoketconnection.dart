import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ScoketProvider extends ChangeNotifier{
   IO.Socket? _socket;

  IO.Socket? get socket => _socket;
   void connect(String token) {
    _socket = IO.io(
      'https://api-communication-application.hilalcart.com/home',
      <String, dynamic>{
        'transports': ['websocket'],
        'auth': {'token': token},
        'autoConnect': false,
      },
    );

    _socket!.connect();
    notifyListeners();
  }

  // Close the socket connection
  void disconnect() {
    if (_socket != null) {
      _socket!.disconnect();
      notifyListeners();
    }
  }
}