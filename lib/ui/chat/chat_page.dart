import 'package:flutter/material.dart';
import 'package:message_app/provider/message_provider.dart';
import 'package:message_app/ui/chat/widget/widget.dart';
import 'package:provider/provider.dart';
import '../../utils/colors.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key? key}) : super(key: key);
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController = TextEditingController();
  final ScrollController _controller = ScrollController();


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<MessageProvider>(context, listen: false).initSocket();
    });
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void _animateToIndex() {
    if (_controller.hasClients) {
      _controller.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      color: AppColor.background,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Container(
            child: Column(
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(context).pop(true),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Icon(Icons.arrow_back,color: Colors.white, size: 30,),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Consumer<MessageProvider>(
                      builder: (context, provider, child) {
                        return ListView.builder(
                          reverse: true,
                          controller: _controller,
                          itemCount: provider.reverseMessage.length,
                          itemBuilder: (context, index) {
                            return !provider.reverseMessage[index].isSender!
                                ? Container(
                              alignment: Alignment.centerLeft,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: size.width * 0.85 - 43.0),
                                child: Container(
                                  margin: const EdgeInsets.all(15.0),
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white24),
                                    color : Colors.white12,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: autoTyper(provider.reverseMessage, index),
                                ),
                              ),
                            )
                                : Container(
                              alignment: Alignment.centerRight,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: size.width * 0.85 - 43.0),
                                child: Container(
                                  margin: const EdgeInsets.all(15.0),
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white24),
                                    gradient: const LinearGradient(
                                      colors: [
                                        AppColor.senderBackground1,
                                        AppColor.senderBackground2
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      // stops: [0.5, 0.5],
                                      // tileMode: TileMode.clamp,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Text(
                                    provider.reverseMessage[index].message!,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16
                                    ),),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  height: 85,
                  color: AppColor.systemNavigationBarColor,
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Container(
                          height: 55.0,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.black38,
                            border: Border.all(color: Colors.white24),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 40,
                                  child: TextField(
                                    controller: messageController,
                                    style: const TextStyle(fontSize: 16.0, color: Colors.white70),
                                    decoration: const InputDecoration(
                                      hintText: 'Ask me anything...',
                                      hintStyle: TextStyle(fontSize: 14.0),
                                      contentPadding:
                                      EdgeInsets.fromLTRB(12.0, 8.0, 8.0, 12.0),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      child: IconButton(
                                        padding: EdgeInsets.all(4),
                                        icon: const Icon(Icons.filter_center_focus, color: Colors.white, size: 25,),
                                        onPressed: () => print('Mic Pressed'),
                                      ),
                                    ),
                                    Container(
                                      height: 30,
                                      width: 30,
                                      child: IconButton(
                                        padding: EdgeInsets.all(4),
                                        icon: const Icon(Icons.mic, color: Colors.white, ),
                                        onPressed: () => print('Mic Pressed'),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),

                      InkWell(
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                        onTap: () {
                          String message = messageController.text;
                          if(message.trim().isNotEmpty){
                            Provider.of<MessageProvider>(context, listen: false).sendMessage(message);
                            messageController.clear();
                            _animateToIndex();
                          }
                        },
                      ),
                      const SizedBox(width: 10.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
