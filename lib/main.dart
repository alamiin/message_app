import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:message_app/provider/message_provider.dart';
import 'package:message_app/theme/dark_theme.dart';
import 'package:message_app/ui/chat/chat_page.dart';
import 'package:message_app/utils/colors.dart';
import 'package:provider/provider.dart';
import 'di_container.dart' as di;

import 'home_page.dart';

Future<void> main() async {
  final WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();
  binding.renderView.automaticSystemUiAdjustment = false;

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColor.statusBarColor,
      systemNavigationBarColor: AppColor.systemNavigationBarColor
  ));

  await di.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<MessageProvider>()),
    ],
    child: MyApp(),
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      home: ChatPage(),
    );
  }
}

