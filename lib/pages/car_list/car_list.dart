import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_tutorial/models/car.dart';
import 'package:flutter_riverpod_tutorial/providers/car_provider/car_provider.dart';
import 'package:flutter_riverpod_tutorial/utils/functions.dart';

class CarList extends StatelessWidget {
  static const String PATH = "carlist";
  const CarList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Cars",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Consumer(builder: (context, watch, child) {
          return watch(carProvider).when(data: (List<Car> list) {
            return ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => CarList(),
                      //   ),
                      // );
                    },
                    child: Container(
                      height: 172,
                      margin: EdgeInsets.only(bottom: 20),
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            width: double.infinity,
                            height: 144,
                            decoration: BoxDecoration(
                                color: hexToColor(list[index].hexColor),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  list[index].name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "\$${list[index].rentalFeePerDay.toString()}/day",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                                Spacer(),
                                Icon(
                                  list[index].isFavorite
                                      ? Icons.star_rounded
                                      : Icons.star_border_rounded,
                                  size: 30,
                                )
                              ],
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 48,
                            child: Image.asset(list[index].urlImage,
                                height: 124, fit: BoxFit.fill),
                          )
                        ],
                      ),
                    ),
                  );
                });
          }, loading: () {
            return CircularProgressIndicator();
          }, error: (error, stackTrace) {
            return Text("error");
          });
        }),
      ),
    );
  }
}
