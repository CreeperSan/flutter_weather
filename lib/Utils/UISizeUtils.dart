import 'dart:ui';
import 'package:flutter/material.dart';

class UISizeUtils{

  static double getStatusBarHeight(BuildContext context){
    return MediaQuery.of(context).padding.top;
  }

  static double getWindowHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }

  static double getWindowWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }

  static double getContentHeight(BuildContext context){
    return MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
  }

}
