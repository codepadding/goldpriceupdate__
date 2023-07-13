import 'package:flutter/material.dart';

class GoldPriceUpdate extends StatelessWidget {
  final Widget widget1;

  GoldPriceUpdate({
    required this.widget1,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Column(
            children: [
              widget1,
              widget1,
              widget1,
              widget1

            ],
          );
        } else {
          return Row(
            children: [
              widget1,
              widget1,
              widget1,
              widget1
            ],
          );
        }
      },
    );
  }
}