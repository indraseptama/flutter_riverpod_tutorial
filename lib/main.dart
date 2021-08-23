import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_tutorial/pages/car_detail/car_detail.dart';
import 'package:flutter_riverpod_tutorial/pages/car_list/car_list.dart';
import 'package:flutter_riverpod_tutorial/pages/on_boarding.dart';
import 'package:flutter_riverpod_tutorial/providers/theme_provider/theme_provider.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final theme = watch(themeNotifierProvider);
      return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: theme,
        initialRoute: OnBoarding.PATH,
        routes: <String, WidgetBuilder>{
          OnBoarding.PATH: (_) => OnBoarding(),
          CarList.PATH: (_) => CarList(),
          CarDetail.PATH: (_) => CarDetail()
        },
      );
    });
  }
}
