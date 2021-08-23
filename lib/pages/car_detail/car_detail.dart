import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_tutorial/components/appbar.dart';
import 'package:flutter_riverpod_tutorial/models/car.dart';
import 'package:flutter_riverpod_tutorial/pages/car_detail/car_detail_provider.dart';
import 'package:flutter_riverpod_tutorial/utils/functions.dart';

class CarDetail extends StatelessWidget {
  static const String PATH = "cardetailnew";
  const CarDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: MyAppBar(),
      body: Consumer(builder: (context, watch, child) {
        final car = watch(carDetailNotifier(id));
        return car.when(data: (Car car) {
          return Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Center(
                child: Image.asset(
                  car.urlImage,
                  width: MediaQuery.of(context).size.width * 0.9,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 30),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: hexToColor(car.hexColor),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              car.name,
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Consumer(builder: (context, watch, child) {
                            final notifier =
                                carDetailFavoriteNotifier(car.isFavorite);
                            final isFavorite = watch(notifier);
                            return isFavorite.when(data: (data) {
                              return IconButton(
                                onPressed: () async {
                                  context
                                      .read(notifier.notifier)
                                      .setFavoriteById(id, !car.isFavorite);
                                },
                                icon: Icon(
                                  car.isFavorite
                                      ? Icons.star_rounded
                                      : Icons.star_border_rounded,
                                  size: 40,
                                ),
                              );
                            }, loading: () {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }, error: (e, s) {
                              return Text(e.toString());
                            });
                          })
                        ],
                      ),
                      Text(
                        "\$${car.rentalFeePerDay.toString()}/day",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 36,
                      ),
                      Text(
                        "Description",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Wanna ride the coolest sport car in the world?",
                        style: TextStyle(fontSize: 16),
                      ),
                      Spacer(),
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16.5),
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              "Book Now",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        }, loading: () {
          return Center(child: CircularProgressIndicator());
        }, error: (error, stackTrace) {
          return Text("error");
        });
      }),
    );
  }
}
