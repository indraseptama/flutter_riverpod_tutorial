import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_tutorial/models/car.dart';
import 'package:flutter_riverpod_tutorial/services/car_service.dart';

final carProvider =
    StateNotifierProvider<CarProvider, AsyncValue<List<Car>>>((ref) {
  return CarProvider(ref.watch(carServiceProvider));
});

class CarProvider extends StateNotifier<AsyncValue<List<Car>>> {
  final CarService _carService;

  CarProvider(this._carService) : super(AsyncLoading()) {
    loadData();
  }

  void loadData() async {
    state = AsyncLoading();
    try {
      List<Car> carList = await _carService.fetchData();
      state = AsyncData(carList);
    } catch (err) {}
  }

  void setFavoriteById(int id, bool isFavorite) async {
    state = AsyncLoading();
    await _carService.setFavoriteById(id, isFavorite);
    loadData();
  }

  Future<Car> getCarById(int id) async {
    Car car = await _carService.getCarById(id);
    loadData();
    return car;
  }
}
