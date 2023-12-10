import 'package:message_app/data/remote/socket/socket_connector.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/foundation.dart';
import '../../data/Message.dart';


class SocketService extends SocketConnector {

  late IO.Socket socket;
  bool isSocketConnected = false;
  @override
  void initSocket(String appBaseUrl, Function connectRoom, Function dataUpdate ) async {
    socket = IO.io(appBaseUrl, <String, dynamic>{
      'autoConnect': true,
      'transports': ['websocket'],
    });
    socket.connect();
    socket.onConnect((_) {
      isSocketConnected = true;
      connectRoom();
    });

    socket.onDisconnect((_) {
      isSocketConnected = false;
      debugPrint('Connection Disconnection');
    });
    socket.onConnectError((err) {
      debugPrint("Socket connection error: $err");
    });
    socket.onError((err) {
      debugPrint("Socket error: $err");
    });

    socket.on('message', (newMessage) {
      var message = Message.fromJson(newMessage);
      dataUpdate(message);
    });

  }
  @override
  void disposeSocket(String userId, String roomId){
    Map leaveRoom = {
      "room": roomId,
      "user_id": userId
    };
    socket.emit('leave', leaveRoom);
    socket.disconnect();
    socket.dispose();
    isSocketConnected = false;
  }
  @override
  void connectRoom(String userId, String roomId){
    Map joinRoom = {
      "room": roomId,
      "user_id": userId
    };
    socket.emit('join', joinRoom);
  }

  @override
  void sendMessage(String message, String userId, String roomId){
    Map messageMap = {
      "room": roomId,
      "user_id": userId,
      "message": message
    };
    socket.emit('message', messageMap);
  }

  @override
  void disconnectRoom(String userId, String roomId) {

  }

}