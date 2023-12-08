import 'package:flutter/material.dart';

import '../utils/colors.dart';

ThemeData darkTheme = ThemeData(
  primaryColor: Colors.blue,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: AppColor.statusBarColor
  ),
  scaffoldBackgroundColor: AppColor.statusBarColor,
);