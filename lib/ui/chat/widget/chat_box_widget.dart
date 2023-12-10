import 'package:flutter/material.dart';
import 'package:message_app/ui/chat/mixin/chat_box_mixin.dart';

import 'widget.dart';

class ChatBoxWidget extends StatelessWidget with ChatBoxMixin{
  final int index;
  final bool isSender;
  final String userName;
  const ChatBoxWidget({Key? key, required this.index, required this.isSender, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.85 - 43.0;
    return Container(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: width),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 15,),

            isSender ? const SizedBox():
            Padding(
             padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
             child:  Text(
               userName,
               style: const TextStyle(
                   color: Colors.grey,
                   fontSize: 12
               ),
             ),
           ),

            Container(
              margin: const EdgeInsets.only(left: 15.0, right: 15, bottom: 15),
              padding: const EdgeInsets.all(10.0),
              decoration: isSender ? getUserBox(): getClientBox(),
              child: autoTyper(isSender, index),
            )
          ],
        ),
      ),
    );
  }
}
