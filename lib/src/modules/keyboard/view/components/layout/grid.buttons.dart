import 'package:ag_keyboard/src/modules/keyboard/view/components/layout/columns/backspace.column.dart';
import 'package:ag_keyboard/src/modules/keyboard/view/components/layout/columns/multiply.column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'columns/division.column.dart';

class GridButtons extends ConsumerWidget {
  final Color? digitColor, operatorColor, backColor;
  final TextEditingController controller;
  const GridButtons({
    this.digitColor,
    required this.controller,
    this.backColor = Colors.red,
    this.operatorColor,
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    return SizedBox(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: BackspaceColumn(
              controller: controller,
              digitColor: digitColor,
              operatorColor: operatorColor,
              backColor: backColor,
            ),
          ),
          Expanded(
            flex: 1,
            child: DivisionColumn(
              controller: controller,
              digitColor: digitColor,
              operatorColor: operatorColor,
            ),
          ),
          Expanded(
            flex: 1,
            child: MultiplyColumn(
              controller: controller,
              operatorColor: operatorColor,
              digitColor: digitColor,
            ),
          ),
        ],
      ),
    );
  }
}
