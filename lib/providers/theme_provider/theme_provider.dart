import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_tutorial/providers/storage_provider/storage_provider.dart';
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
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF212121),
    accentColor: Colors.white,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
  );

  final lightTheme = ThemeData(
    fontFamily: "Poppins",
    primarySwatch: Colors.grey,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
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
