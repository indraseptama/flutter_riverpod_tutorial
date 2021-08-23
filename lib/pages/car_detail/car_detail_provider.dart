import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_tutorial/models/car.dart';
import 'package:flutter_riverpod_tutorial/services/car_service.dart';

final carDetailNotifier =
    FutureProvider.autoDispose.family<Car, int>((ref, id) {
  final api = ref.watch(carServiceProvider);
  return api.getCarById(id);
});

final carDetailFavoriteNotifier = StateNotifierProvider.family<
    CarDetailFavoriteNotifier, AsyncValue<bool>, bool>((ref, isFavorite) {
  return CarDetailFavoriteNotifier(ref.watch(carServiceProvider), isFavorite);
});

class CarDetailFavoriteNotifier extends StateNotifier<AsyncValue<bool>> {
  final CarService _carService;
  final bool isFavorite;
  CarDetailFavoriteNotifier(this._carService, this.isFavorite)
      : super(AsyncData(isFavorite));

  Future<void> setFavoriteById(int id, bool isFavorite) async {
    state = AsyncLoading();
    await _carService.setFavoriteById(id, isFavorite);
    state = AsyncData(isFavorite);
  }
}

// class CarDetailNotifier extends StateNotifier<AsyncValue<Car>> {
//   final CarService _carService;

//   CarDetailNotifier(this._carService) : super(AsyncLoading());

//   Future<void> getUserInfo(int id) async {
//     try {
//       state = AsyncLoading();
//       final car = await _carService.getCarById(id);
//       state = AsyncData(car);
//     } catch (e) {
//       state = AsyncError(e);
//     }
//   }
// }
