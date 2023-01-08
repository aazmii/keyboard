import 'package:ag_keyboard/src/modules/keyboard/const/enums.dart';
import 'package:ag_keyboard/src/modules/keyboard/provider/helper.dart';
import 'package:ag_keyboard/src/modules/keyboard/provider/key.press.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'components/numpad.layout.dart';
import 'history.board/history.board.dart';

class AgKeyboard extends ConsumerWidget {
  AgKeyboard({
    super.key,
    required this.controller,
    this.backgroundColor,
    this.digitColor = Colors.blue,
    this.operatorColor = Colors.cyan,
    required this.focusNode,
    this.backButtonColor,
    this.pointColor = Colors.grey,
    this.resultColor = Colors.grey,
    this.displayColor = Colors.grey,
    this.numpadHeight,
    this.historyColor,
  });
  final keyPressProvider = NotifierProvider<KeyPressProvider, KeyPressProvider>(
      KeyPressProvider.new);

  final TextEditingController controller;
  final displayHeight = 70.0;
  final double? numpadHeight;
  final Color? backgroundColor,
      digitColor,
      operatorColor,
      backButtonColor,
      pointColor,
      resultColor,
      displayColor,
      historyColor;
  final FocusNode focusNode;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keyPress = ref.watch(keyPressProvider);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        DeviceType deviceType = getDeviceType(constraints);
        return Visibility(
          visible: focusNode.hasFocus,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  NumPadLayout(
                    deviceType: deviceType,
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
              if (deviceType == DeviceType.mobile)
                HistoryBoard(
                  historyColor: historyColor,
                )
            ],
          ),
        );
      },
    );
  }

  static String? checkExpression(String? value) {
    return checkInuput(value);
  }
}
