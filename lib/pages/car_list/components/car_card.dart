import 'package:flutter/material.dart';
import 'package:flutter_riverpod_tutorial/utils/functions.dart';

class CarCard extends StatelessWidget {
  final double height;
  final String hexColor;
  final String name;
  final String urlImage;
  final int rentalFeePerDay;
  final int id;
  final bool isFavorite;

  const CarCard(
      {Key? key,
      required this.height,
      required this.hexColor,
      required this.name,
      required this.rentalFeePerDay,
      required this.id,
      required this.isFavorite,
      required this.urlImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        height: height,
        margin: EdgeInsets.only(bottom: 20),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              height: 144,
              decoration: BoxDecoration(
                  color: hexToColor(hexColor),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "\$${rentalFeePerDay.toString()}/day",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                  Spacer(),
                  Icon(
                    isFavorite ? Icons.star_rounded : Icons.star_border_rounded,
                    size: 30,
                  )
                ],
              ),
            ),
            Positioned(
              right: 0,
              top: 48,
              child: Image.asset(urlImage, height: 124, fit: BoxFit.fill),
            )
          ],
        ),
      ),
    );
    ;
  }
}
