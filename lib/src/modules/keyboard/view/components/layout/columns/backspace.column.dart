import 'package:ag_keyboard/src/modules/keyboard/const/enums.dart';
import 'package:ag_keyboard/src/modules/keyboard/provider/providers.dart';
import 'package:ag_keyboard/src/modules/keyboard/view/components/ag.button.dart';
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
          child: AgButton(
            calcKey: CalcKey.backSpace,
            iconData: Icons.backspace_outlined,
            color: Theme.of(context).colorScheme.error,
            onBackspace: () => press.backspace(
              textController: controller,
              ref: ref,
            ),
            onLongPressOnBackButton: () {
              ref.read(displayTextProvider.notifier).state = '';
              controller.clear();
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: AgButton(
            calcKey: CalcKey.one,
            color: digitColor,
            // controller: controller,
            onTextInput: (value) {
              press.insertText(myText: value, ref: ref, controller: controller);
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: AgButton(
            calcKey: CalcKey.four,
            color: digitColor,
            // controller: controller,
            onTextInput: (value) => press.insertText(
                myText: value, ref: ref, controller: controller),
          ),
        ),
        Expanded(
          flex: 1,
          child: AgButton(
            calcKey: CalcKey.seven,
            color: digitColor,
            // controller: controller,
            onTextInput: (value) => press.insertText(
                myText: value, ref: ref, controller: controller),
          ),
        ),
      ],
    );
  }
}
