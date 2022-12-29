import 'package:ag_keyboard/src/modules/keyboard/logic/keyboard.logic.dart';
import 'package:ag_keyboard/src/modules/keyboard/provider/calculation.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'keyboard_layout.dart';

class AgKeyboard extends ConsumerWidget {
  const AgKeyboard({
    super.key,
    required this.controller,
    this.backgroundColor,
    this.digitColor = Colors.blue,
    this.operatorColor = Colors.cyan,
    required this.focusNode,
    this.backButtonColor = Colors.red,
    this.pointColor = Colors.grey,
    this.resultColor = Colors.cyan,
    this.displayColor = Colors.grey,
  });
  final TextEditingController controller;
  final int backspaceIndex = 12;

  final Color? backgroundColor,
      digitColor,
      operatorColor,
      backButtonColor,
      pointColor,
      resultColor,
      displayColor;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Visibility(
      visible: focusNode.hasFocus,
      child: _buildKeyboard(context, ref),
    );
  }

  Column _buildKeyboard(BuildContext context, WidgetRef ref) {
    String displayText = ref.watch(displayTextProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 70,
          width: double.infinity,
          color: Colors.black45,
          child: Align(
            alignment: Alignment.centerLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                displayText,
                style: const TextStyle(fontSize: 32),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          height: 350,
          color: backgroundColor,
          child: Consumer(
            builder: (context, ref, child) {
              return KeyboardLayout(
                onTextInput: (myText) {
                  KeyboardLogic().insertText(
                    ref: ref,
                    myText: myText,
                    ted: controller,
                  );
                },
                onBackspace: () {
                  KeyboardLogic.backspace(textController: controller, ref: ref);
                },
                digitColor: digitColor,
                operatorColor: operatorColor,
                pointColor: pointColor,
                backButtonColor: backButtonColor,
                resultColor: resultColor,
                textController: controller,
              );
            },
          ),
        )
      ],
    );
  }
}
