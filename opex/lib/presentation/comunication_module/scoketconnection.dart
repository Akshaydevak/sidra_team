import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_common/src/util/event_emitter.dart';

class scoketProvider extends ChangeNotifier{
   IO.Socket? _socket;
  SharedPreferences? pref;
  IO.Socket? get socket => _socket;
   void connect(String token) {
    _socket = IO.io(
      'https://api-communication-application.hilalcart.com/home',
      // 'http://192.168.1.187:5500/home',
      // "https://5z7l1nh4-5500.inc1.devtunnels.ms/home",
      <String, dynamic>{
        'transports': ['websocket'],
        'auth': {'token': token},
        'autoConnect': false,
      },
    );

    _socket!.connect();
      _socket!.on('connect', (_) => print('connectt success: ${_socket!.id}'));
      _socket!.on('user.id', (data) {
      //loginuserId = data;
      print("vgyvgvh$data");
      // setState(() {});
    });
    _socket!.on('user.id', _userid);
    notifyListeners();
  }

  // Close the socket connection
  void disconnect() {
    if (_socket != null) {
      _socket!.disconnect();
      print('connectt disconnect: ${_socket!.id}');
      notifyListeners();
    }
  }
  void _userid(data)async{
 pref = await SharedPreferences.getInstance();
pref!.setString("loginuserid", data);
}
}

class scoketgrpProvider extends ChangeNotifier{
   IO.Socket? _socket;
  SharedPreferences? pref;
  IO.Socket? get socket => _socket;
   void connect(String token) {
    _socket = IO.io(
      'https://api-communication-application.hilalcart.com/group',
      // 'http://192.168.1.187:5500/home',
      // "https://5z7l1nh4-5500.inc1.devtunnels.ms/group",
      <String, dynamic>{
        'transports': ['websocket'],
        'auth': {'token': token},
        'autoConnect': false,
      },
    );

    _socket!.connect();
      _socket!.on('connect', (_) => print('connectwt success: ${_socket!.id}'));
      _socket!.on('user.id', (data) {
      //loginuserId = data;
      print("vgyvgvh$data");
      // setState(() {});
    });
    _socket!.on('user.id', _userid);
    notifyListeners();
  }

  // Close the socket connection
  void disconnect() {
    if (_socket != null) {
      _socket!.disconnect();
      print('connectt disconnect: ${_socket!.id}');
      notifyListeners();
    }
  }
  void _userid(data)async{
 pref = await SharedPreferences.getInstance();
pref!.setString("logingrpuserid", data);
}
}

class FocusState extends ChangeNotifier {
  bool _shouldFocus = false;

  bool get shouldFocus => _shouldFocus;

  void setFocus(bool value) {
    _shouldFocus = value;
    notifyListeners();
  }
}