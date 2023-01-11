import 'package:flutter/material.dart';

import 'bottom.row.dart';
import 'grid.buttons.dart';

class LeftOneThird extends StatelessWidget {
  final Color? digitColor, operatorColor, backColor;
  final TextEditingController controller;
  const LeftOneThird({
    this.digitColor,
    this.operatorColor,
    this.backColor,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: GridButtons(
            digitColor: digitColor,
            operatorColor: operatorColor,
            controller: controller,
            backColor: backColor,
          ),
        ),
        Expanded(
          flex: 1,
          child: BottomRow(
            digitColor: digitColor,
            operatorColor: operatorColor,
            controller: controller,
          ),
        ),
      ],
    );
  }
}
