import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_tutorial/components/appbar.dart';
import 'package:flutter_riverpod_tutorial/models/car.dart';
import 'package:flutter_riverpod_tutorial/providers/car_provider/car_provider.dart';
import 'package:flutter_riverpod_tutorial/utils/functions.dart';

class CarDetail extends StatefulWidget {
  static const String PATH = "cardetail";
  const CarDetail({Key? key}) : super(key: key);

  @override
  _CarDetailState createState() => _CarDetailState();
}

class _CarDetailState extends State<CarDetail> {
  bool firstLoad = true;

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: MyAppBar(),
      body: FutureBuilder<Car>(
          future: context.read(carProvider.notifier).getCarById(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting &&
                firstLoad)
              return Center(
                child: CircularProgressIndicator(),
              );
            else {
              firstLoad = false;
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              } else {
                bool isFavorite = snapshot.data!.isFavorite;

                return Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Image.asset(
                        snapshot.data!.urlImage,
                        width: MediaQuery.of(context).size.width * 0.9,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 30, right: 30, top: 40, bottom: 30),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: hexToColor(snapshot.data!.hexColor),
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
                                    snapshot.data!.name,
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    context
                                        .read(carProvider.notifier)
                                        .setFavoriteById(
                                            id, !snapshot.data!.isFavorite);
                                    Car car = await context
                                        .read(carProvider.notifier)
                                        .getCarById(id);
                                    setState(() {
                                      isFavorite = car.isFavorite;
                                    });
                                  },
                                  icon: Icon(
                                    isFavorite
                                        ? Icons.star_rounded
                                        : Icons.star_border_rounded,
                                    size: 40,
                                  ),
                                )
                              ],
                            ),
                            Text(
                              "\$${snapshot.data!.rentalFeePerDay.toString()}/day",
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
              }
            }
          }),
    );
  }
}
