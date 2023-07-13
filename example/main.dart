import 'package:flutter/material.dart';
import 'package:goldpriceupdate/goldpriceupdate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Demo'),
        ),
        body: Center(
          child: GoldPriceUpdate(
            widget1: Container(
              width: 100,
              height: 100,
              color: Colors.red,
            )
          ),
        ),
      ),
    );
  }
}