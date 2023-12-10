import 'package:flutter/material.dart';
import 'package:message_app/utils/colors.dart';

mixin ChatBoxMixin{
  BoxDecoration getUserBox(){
    return BoxDecoration(
      border: Border.all(color: Colors.white24),
      gradient: const LinearGradient(
        colors: [
          AppColor.senderBackground1,
          AppColor.senderBackground2
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(8.0),
    );
  }
  BoxDecoration getClientBox(){
    return BoxDecoration(
      border: Border.all(color: Colors.white24),
      color : Colors.white12,
      borderRadius: BorderRadius.circular(8.0),
    );
  }
}