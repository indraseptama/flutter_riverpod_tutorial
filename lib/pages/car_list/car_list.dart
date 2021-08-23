import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_tutorial/components/appbar.dart';
import 'package:flutter_riverpod_tutorial/models/car.dart';
import 'package:flutter_riverpod_tutorial/pages/car_list/components/car_card.dart';
import 'package:flutter_riverpod_tutorial/providers/car_provider/car_provider.dart';

class CarList extends StatelessWidget {
  static const String PATH = "carlist";
  const CarList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Consumer(builder: (context, watch, child) {
          return watch(carProvider).when(data: (List<Car> list) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read(carProvider.notifier).loadData();
              },
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CarCard(
                        height: 172,
                        hexColor: list[index].hexColor,
                        name: list[index].name,
                        rentalFeePerDay: list[index].rentalFeePerDay,
                        id: list[index].id,
                        isFavorite: list[index].isFavorite,
                        urlImage: list[index].urlImage);
                  }),
            );
          }, loading: () {
            return Center(child: CircularProgressIndicator());
          }, error: (error, stackTrace) {
            return Text("error");
          });
        }),
      ),
    );
  }
}
