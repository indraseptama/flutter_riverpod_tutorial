import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_tutorial/models/car.dart';

final carServiceProvider = Provider<CarService>((ref) => CarService());

class CarService {
  List<Car> carList = [
    new Car(
        id: 1,
        name: "Classic Car",
        urlImage: "assets/images/car_1.png",
        rentalFeePerDay: 34,
        isFavorite: false,
        hexColor: "#B67853"),
    new Car(
        id: 2,
        name: "Sport Car",
        urlImage: "assets/images/car_2.png",
        rentalFeePerDay: 55,
        isFavorite: false,
        hexColor: "#60B5F4"),
    new Car(
        id: 3,
        name: "Flying Car",
        urlImage: "assets/images/car_3.png",
        rentalFeePerDay: 500,
        isFavorite: false,
        hexColor: "#8382C2"),
    new Car(
        id: 4,
        name: "Electric Car",
        urlImage: "assets/images/car_4.png",
        rentalFeePerDay: 45,
        isFavorite: false,
        hexColor: "#2A3640"),
  ];

  Future<List<Car>> fetchData() async {
    return Future.delayed(Duration(milliseconds: 200), () {
      return carList;
    });
  }

  Future<void> setFavoriteById(int id, bool isFavorite) async {
    Car car = carList.firstWhere((car) => car.id == id);
    int index = carList.indexOf(car);
    carList[index].isFavorite = isFavorite;
  }

  Future<Car> getCarById(int id) async {
    return Future.delayed(Duration(milliseconds: 200), () {
      return carList.firstWhere((car) => car.id == id);
    });
  }
}
