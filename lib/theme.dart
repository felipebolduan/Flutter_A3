import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PreferenciaTema {
  static ValueNotifier<Brightness> tema = ValueNotifier(Brightness.light);

  static setTema() {
    tema.value = WidgetsBinding.instance!.platformDispatcher.platformBrightness;
    ChangeStatusNavigationBar();
  }

  static ChangeStatusNavigationBar() {
    bool isDark = tema.value == Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarColor: isDark ? const Color(0xFF424242) : Colors.deepPurple,
      systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: isDark ? const Color(0xFF313131) : Colors.deepPurple,
    ));
  }
}