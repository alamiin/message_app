
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:message_app/data/data/Message.dart';
import 'package:message_app/provider/message_provider.dart';
import 'package:provider/provider.dart';


Widget autoTyper(List<Message> reverseMessage, int index){
  return Consumer<MessageProvider>(
    builder: (context, provider, child) {
      if(index == 0 &&  reverseMessage.length == provider.len+2){
        return SizedBox(
          child: DefaultTextStyle(
            style: const TextStyle(
              color: Colors.white,
                fontSize: 16
            ),
            child: AnimatedTextKit(
              isRepeatingAnimation: false,
              animatedTexts: [
                TyperAnimatedText(reverseMessage[index].message!),
              ],
              onFinished: () {
                provider.updateLen(reverseMessage.length);
              },
            ),
          ),
        );
      }else{
        return Text(
            reverseMessage[index].message!,
                style: const TextStyle(
             color: Colors.white,
                    fontSize: 16
        ),
        );
      }
    },
  );

}