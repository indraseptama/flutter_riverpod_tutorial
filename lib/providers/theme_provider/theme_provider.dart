import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_tutorial/providers/storage_provider/storage_provider.dart';
import 'package:flutter_riverpod_tutorial/utils/functions.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final themeNotifierProvider =
    StateNotifierProvider.autoDispose<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier(ref.read(storageProvider));
});

class ThemeNotifier extends StateNotifier<ThemeData> {
  final FlutterSecureStorage secureStorage;
  final darkTheme = ThemeData(
    fontFamily: "Poppins",
    primarySwatch: Colors.grey,
    primaryColor: hexToColor("#1814E4"),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: hexToColor("#191D21"),
    accentColor: Colors.white,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
  );

  final lightTheme = ThemeData(
    fontFamily: "Poppins",
    primarySwatch: Colors.grey,
    primaryColor: hexToColor("#FA7F35"),
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFE5E5E5),
    accentColor: Colors.black,
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,
  );

  ThemeNotifier(this.secureStorage) : super(ThemeData()) {
    secureStorage.read(key: 'themeMode').then((value) => {
          if (value == 'light') {state = lightTheme} else {state = darkTheme}
        });
  }

  void setDarkMode() {
    state = darkTheme;
    secureStorage.write(key: 'themeMode', value: 'dark');
  }

  void setLightMode() {
    state = lightTheme;
    secureStorage.write(key: 'themeMode', value: 'light');
  }
}
