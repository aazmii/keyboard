import 'package:ag_keyboard/src/modules/keyboard/enum/enums.dart';
import 'package:ag_keyboard/src/modules/keyboard/view/components/ag.button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../provider/key.press.provider.dart';

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
    final press = ref.watch(keyPressProvider.notifier);
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: AgButton(
            calcKey: CalcKey.zero,
            color: digitColor,
            onTextInput: (value) {
              press.insertText(myText: value, controller: controller);
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: AgButton(
            calcKey: CalcKey.point,
            color: digitColor,
            onTextInput: (value) {
              press.insertText(myText: value,  controller: controller);
            },
          ),
        ),
      ],
    );
  }
}
