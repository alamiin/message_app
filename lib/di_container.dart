import 'package:get_it/get_it.dart';
import 'package:message_app/provider/message_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {

  // Provider
  sl.registerFactory(() => MessageProvider());

}
