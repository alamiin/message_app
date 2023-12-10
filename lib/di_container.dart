import 'package:get_it/get_it.dart';
import 'package:message_app/data/repository/message_repo.dart';
import 'package:message_app/provider/message_provider.dart';

import 'data/remote/socket/socker_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerFactory(() => SocketService());

  // Provider
  sl.registerFactory(() => MessageProvider(messageRepo: sl()));
  sl.registerFactory(() => MessageRepo(socketService: sl()));

}
