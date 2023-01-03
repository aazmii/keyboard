import 'package:ag_keyboard/src/modules/keyboard/provider/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultButton extends ConsumerWidget {
  const ResultButton({
    super.key,
    required this.controller,
    this.buttonColor,
    this.flex = 1,
  });
  final Color? buttonColor;
  final TextEditingController controller;
  final int? flex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Flexible(
      flex: flex ?? 1,
      child: GestureDetector(
        onTap: () {
          calculateResult(ref, controller);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: buttonColor,
          ),
          child: const Center(
            child: Text(
              '=',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
