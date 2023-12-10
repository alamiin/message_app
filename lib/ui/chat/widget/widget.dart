
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:message_app/data/data/Message.dart';
import 'package:message_app/provider/message_provider.dart';
import 'package:provider/provider.dart';


Widget autoTyper(bool isSender, int index){
  return Consumer<MessageProvider>(
    builder: (context, provider, child) {
      if( !isSender && index == 0 &&  provider.reverseMessage.length == provider.len+2){
        return SizedBox(
          child: DefaultTextStyle(
            style: const TextStyle(
              color: Colors.white,
                fontSize: 16
            ),
            child: AnimatedTextKit(
              isRepeatingAnimation: false,
              animatedTexts: [
                TyperAnimatedText(provider.reverseMessage[index].message!),
              ],
              onFinished: () {
                provider.updateLen(provider.reverseMessage.length);
              },
            ),
          ),
        );
      }else{
        return Text(
          provider.reverseMessage[index].message!,
                style: const TextStyle(
             color: Colors.white,
                    fontSize: 16
        ),
        );
      }
    },
  );

}