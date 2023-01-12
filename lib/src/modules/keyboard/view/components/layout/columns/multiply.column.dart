import 'package:ag_keyboard/src/modules/keyboard/const/enums.dart';
import 'package:ag_keyboard/src/modules/keyboard/provider/providers.dart';
import 'package:ag_keyboard/src/modules/keyboard/view/components/ag.button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MultiplyColumn extends ConsumerWidget {
  const MultiplyColumn({
    super.key,
    required this.controller,
    this.digitColor,
    this.operatorColor,
  });
  final TextEditingController controller;
  final Color? digitColor, operatorColor;

  @override
  Widget build(BuildContext context, ref) {
    final press = ref.watch(keyPressProvider);
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: AgButton(
            calcKey: CalcKey.multiply,
            color: operatorColor,
            onTextInput: (value) {
              press.insertText(myText: value, ref: ref, controller: controller);
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: AgButton(
            calcKey: CalcKey.three,
            color: digitColor,
            onTextInput: (value) {
              press.insertText(myText: value, ref: ref, controller: controller);
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: AgButton(
            calcKey: CalcKey.six,
            color: digitColor,
            onTextInput: (value) {
              press.insertText(myText: value, ref: ref, controller: controller);
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: AgButton(
            calcKey: CalcKey.nine,
            color: digitColor,
            onTextInput: (value) {
              press.insertText(myText: value, ref: ref, controller: controller);
            },
          ),
        ),
      ],
    );
  }
}
