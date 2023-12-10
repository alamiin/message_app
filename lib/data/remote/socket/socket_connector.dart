abstract class SocketConnector{
  void initSocket(String appBaseUrl, Function connectRoom, Function dataUpdate);
  void disposeSocket(String userId, String roomId);
  void connectRoom(String userId, String roomId);
  void disconnectRoom(String userId, String roomId);

  void sendMessage(String message, String userId, String roomId);
}