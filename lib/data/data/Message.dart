
import '../../utils/user_helper.dart';

class Message{
  String? message;
  String? room;
  String? userId;
  bool? isSender;
  Message({required this.message, required this.isSender});

  Message.fromJson(dynamic json) {
    message = json['message'];
    room = json['room'];
    userId = json['user_id'];
    isSender = UserHelper.isSameUser(json['user_id']);
  }

}