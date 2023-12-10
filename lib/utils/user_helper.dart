import 'dart:io';

class UserHelper{
  static String getUser(){
    if (Platform.isAndroid) {
      return "Android";
    } else if (Platform.isIOS) {
      return "iOS";
    }else{
      return "Web";
    }
  }

  static bool isSameUser(String user){
    if(getUser() == user){
      return true;
    }else{
      return false;
    }
  }
}