
import 'package:flutter/cupertino.dart';
import 'package:message_app/utils/user_helper.dart';
import 'dart:io' show Platform;
import '../data/data/Message.dart';
import '../data/repository/message_repo.dart';

class MessageProvider extends ChangeNotifier{

  final MessageRepo messageRepo;

  MessageProvider({required this.messageRepo});



  /// here we create a variable to track a new item when added. So we can easily handle typing animation.
  int len = 0;

  List<Message> allMessage = [];
  List<Message> reverseMessage = [];

  /// setting message
  void setMessage(Message message){
    allMessage.add(message);
    reverseMessage = allMessage.reversed.toList();
    len = reverseMessage.length -2;
    notifyListeners();
  }

  /// here we are updating length when ui render is done.
  void updateLen(int l){
    len = l;
    notifyListeners();
  }

  List<String> messageList = [];





  @override
  void dispose() {
    disposeSocket();
    super.dispose();
  }

  String roomId = "room123";
  String userId =  UserHelper.getUser();

  void initSocket() {
    messageRepo.initSocket(
      connectRoom: connectRoom,
      dataUpdate: setMessage
    );
  }

  void disposeSocket(){
    messageRepo.disposeSocket(userId, roomId);
  }

  void connectRoom(){
    messageRepo.connectRoom(userId, roomId);
  }

  void sendMessage(String message){
    messageRepo.sendMessage(message, userId, roomId);
  }


}