import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_tutorial/enum/mode.dart';
import 'package:flutter_riverpod_tutorial/providers/storage_provider/storage_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final modeNotifierProvider =
    StateNotifierProvider.autoDispose<ModeNotifier, ModeType>((ref) {
  return ModeNotifier(ref.read(storageProvider));
});

class ModeNotifier extends StateNotifier<ModeType> {
  final FlutterSecureStorage secureStorage;
  ModeNotifier(this.secureStorage) : super(ModeType.Light) {
    secureStorage.read(key: 'themeMode').then((value) => {
          if (value == 'light')
            {state = ModeType.Light}
          else
            {state = ModeType.Dark}
        });
  }

  setDarkMode() {
    state = ModeType.Dark;
  }

  setLightMode() {
    state = ModeType.Light;
  }
}
