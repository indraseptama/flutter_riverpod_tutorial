import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_tutorial/enum/mode.dart';
import 'package:flutter_riverpod_tutorial/pages/car_list/car_list.dart';
import 'package:flutter_riverpod_tutorial/providers/mode/mode.dart';
import 'package:flutter_riverpod_tutorial/providers/theme_provider/theme_provider.dart';

class OnBoarding extends StatelessWidget {
  static const String PATH = "onboarding";
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 32,
            ),
            Text(
              "Beepy",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            SizedBox(
              height: 32,
            ),
            Image(image: AssetImage("assets/images/on_boarding_image.png")),
            SizedBox(
              height: 32,
            ),
            Text("Find Your Vehicle",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24)),
            SizedBox(
              height: 16,
            ),
            Text("Find the perfect vehicle for every\noccasion!",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
            SizedBox(
              height: 32,
            ),
            Consumer(builder: (context, watch, child) {
              final mode = watch(modeNotifierProvider);
              return Switch(
                value: mode == ModeType.Light,
                onChanged: (newValue) {
                  if (newValue) {
                    context.read(themeNotifierProvider.notifier).setLightMode();
                    context.read(modeNotifierProvider.notifier).setLightMode();
                  } else {
                    context.read(themeNotifierProvider.notifier).setDarkMode();
                    context.read(modeNotifierProvider.notifier).setDarkMode();
                  }
                },
              );
            }),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, CarList.PATH);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Continue",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
