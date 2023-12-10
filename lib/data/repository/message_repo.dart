
import 'package:message_app/data/remote/socket/socker_service.dart';
import 'package:message_app/utils/utils.dart';

class MessageRepo{
  final SocketService socketService;
  MessageRepo({required this.socketService});

  void initSocket({required Function connectRoom, required Function dataUpdate}){
    socketService.initSocket(appBaseUrl, connectRoom, dataUpdate);
  }

  void disposeSocket(String userId, String roomId){
    socketService.disposeSocket(userId, roomId);
  }

  void connectRoom(String userId, String roomId){
    socketService.connectRoom(userId, roomId);
  }

  void disconnectRoom(String userId, String roomId){
    socketService.disconnectRoom(userId, roomId);
  }

  void sendMessage(String message, String userId, String roomId){
    socketService.sendMessage(message, userId, roomId);
  }

}