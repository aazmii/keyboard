import 'package:ag_keyboard/src/modules/keyboard/const/enums.dart';
import 'package:ag_keyboard/src/modules/keyboard/provider/providers.dart';
import 'package:ag_keyboard/src/modules/keyboard/view/components/custom.key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomRow extends ConsumerWidget {
  final Color? digitColor, operatorColor;
  final TextEditingController controller;
  const BottomRow({
    super.key,
    this.digitColor,
    required this.controller,
    this.operatorColor,
  });

  @override
  Widget build(BuildContext context, ref) {
    final press = ref.watch(keyPressProvider);
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: CustomKey(
            calcKey: CalcKey.zero,
            color: digitColor,
            onTextInput: (value) {
              press.insertText(myText: value, ref: ref, controller: controller);
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: CustomKey(
            calcKey: CalcKey.point,
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
