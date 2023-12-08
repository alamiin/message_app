
import 'package:flutter/cupertino.dart';
import 'package:message_app/utils/utils.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../data/data/Message.dart';

class MessageProvider extends ChangeNotifier{

  // here we create a variable to track a new item when added. So we can easily handle typing animation.
  int len = 0;

  List<Message> allMessage = [];
  List<Message> reverseMessage = [];

  // setting message
  void setMessage(Message message){
    allMessage.add(message);
    reverseMessage = allMessage.reversed.toList();
    len = reverseMessage.length -2;
    notifyListeners();
  }

  // here we are updating length when ui render is done.
  void updateLen(int l){
    len = l;
    notifyListeners();
  }

  List<String> messageList = [];

  String roomId = "room123";
  String userId = "user100";
  late IO.Socket socket;

  @override
  void dispose() {
    disposeSocket();
    super.dispose();
  }


  void initSocket() {
    socket = IO.io(appBaseUrl, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socket.connect();
    socket.onConnect((_) {
      print('Connection established');
      connectRoom();
    });
    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.onConnectError((err) => print(err));
    socket.onError((err) => print(err));

    socket.on('message', (newMessage) {
      var message = Message.fromJson(newMessage);
      setMessage(message);
    });
  }


  void disposeSocket(){
    Map leaveRoom = {
      "room": roomId,
      "user_id": userId
    };
    socket.emit('leave', leaveRoom);
    socket.disconnect();
    socket.dispose();
  }

  void connectRoom(){
    Map joinRoom = {
      "room": roomId,
      "user_id": userId
    };
    socket.emit('join', joinRoom);
  }

  void sendMessage(String message){
    Map messageMap = {
      "room": roomId,
      "user_id": userId,
      "message": message
    };
    socket.emit('message', messageMap);
  }


}