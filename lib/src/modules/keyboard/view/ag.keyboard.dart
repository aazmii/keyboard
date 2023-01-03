import 'package:ag_keyboard/src/modules/keyboard/helper.dart';
import 'package:ag_keyboard/src/modules/keyboard/history.dart';
import 'package:ag_keyboard/src/modules/keyboard/provider/key.press.provider.dart';
import 'package:ag_keyboard/src/modules/keyboard/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'components/keyboard.display.dart';
import 'components/numpad.dart';

class AgKeyboard extends ConsumerWidget {
  AgKeyboard({
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
  final keyPressProvider = NotifierProvider<KeyPressProvider, KeyPressProvider>(
      KeyPressProvider.new);

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
    String displayText = ref.watch(displayTextProvider);
    String historyText = History.asText;

    final keyPress = ref.watch(keyPressProvider);
    return Visibility(
      visible: focusNode.hasFocus,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          KeyboardDisplay(displayText: '$displayText$historyText'),
          NumPad(
            backgroundColor: backgroundColor,
            keyPress: keyPress,
            controller: controller,
            digitColor: digitColor,
            operatorColor: operatorColor,
            pointColor: pointColor,
            backButtonColor: backButtonColor,
            resultColor: resultColor,
            onTextInput: (value) {
              keyPress.insertText(myText: value, ref: ref, ted: controller);
            },
            onBackspace: () => keyPress.backspace(
              textController: controller,
              ref: ref,
            ),
          ),
        ],
      ),
    );
  }

  static String? checkExpression(String? value) {
    return checkInuput(value);
  }
}
