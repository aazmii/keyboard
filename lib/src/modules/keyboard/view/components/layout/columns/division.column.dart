import 'package:ag_keyboard/src/modules/keyboard/const/enums.dart';
import 'package:ag_keyboard/src/modules/keyboard/provider/providers.dart';
import 'package:ag_keyboard/src/modules/keyboard/view/components/custom.key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DivisionColumn extends ConsumerWidget {
  const DivisionColumn({
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
          child: CustomKey(
            calcKey: CalcKey.division,
            color: operatorColor,
            // controller: controller,
            onTextInput: (value) {
              press.insertText(myText: value, ref: ref, controller: controller);
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: CustomKey(
            calcKey: CalcKey.two,
            color: digitColor,
            // controller: controller,
            onTextInput: (value) {
              press.insertText(myText: value, ref: ref, controller: controller);
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: CustomKey(
            calcKey: CalcKey.five,
            color: digitColor,
            // controller: controller,
            onTextInput: (value) {
              press.insertText(myText: value, ref: ref, controller: controller);
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: CustomKey(
            calcKey: CalcKey.eight,
            color: digitColor,
            // controller: controller,
            onTextInput: (value) {
              press.insertText(myText: value, ref: ref, controller: controller);
            },
          ),
        ),
      ],
    );
  }
}
