import 'package:ag_keyboard/src/modules/keyboard/provider/helper.dart';
import 'package:ag_keyboard/src/modules/keyboard/provider/key.press.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'components/display.dart';
import 'components/numpad.dart';
import 'history.board/history.board.dart';

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
    this.numPadHeight = 350,
    this.displayHeight = 70,
  });
  final keyPressProvider = NotifierProvider<KeyPressProvider, KeyPressProvider>(
      KeyPressProvider.new);

  final TextEditingController controller;
  final double? numPadHeight, displayHeight;
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
    final keyPress = ref.watch(keyPressProvider);
    return Visibility(
      visible: focusNode.hasFocus,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Display(),
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
                  keyPress.insertText(
                      myText: value, ref: ref, controller: controller);
                },
                onBackspace: () => keyPress.backspace(
                  textController: controller,
                  ref: ref,
                ),
              ),
            ],
          ),
          HistoryBoard(
            numPadHeight: numPadHeight,
            displayHeight: displayHeight,
          ),
        ],
      ),
    );
  }

  static String? checkExpression(String? value) {
    return checkInuput(value);
  }
}
