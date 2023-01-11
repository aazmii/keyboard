import 'package:ag_keyboard/src/modules/keyboard/const/enums.dart';
import 'package:ag_keyboard/src/modules/keyboard/provider/providers.dart';
import 'package:ag_keyboard/src/modules/keyboard/view/components/custom.key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BackspaceColumn extends ConsumerWidget {
  const BackspaceColumn({
    super.key,
    required this.controller,
    this.digitColor,
    this.operatorColor,
    this.backColor,
  });
  final TextEditingController controller;
  final Color? digitColor, operatorColor, backColor;

  @override
  Widget build(BuildContext context, ref) {
    final press = ref.watch(keyPressProvider);
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: CustomKey(
              calcKey: CalcKey.backSpace,
              iconData: Icons.backspace_outlined,
              color: backColor ?? Colors.red,
              onBackspace: () =>
                  press.backspace(textController: controller, ref: ref)),
        ),
        Expanded(
          flex: 1,
          child: CustomKey(
            calcKey: CalcKey.one,
            color: digitColor,
            onTextInput: (value) {
              press.insertText(myText: value, ref: ref, controller: controller);
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: CustomKey(
            calcKey: CalcKey.four,
            color: digitColor,
            onTextInput: (value) => press.insertText(
                myText: value, ref: ref, controller: controller),
          ),
        ),
        Expanded(
          flex: 1,
          child: CustomKey(
            calcKey: CalcKey.seven,
            color: digitColor,
            onTextInput: (value) => press.insertText(
                myText: value, ref: ref, controller: controller),
          ),
        ),
      ],
    );
  }
}
