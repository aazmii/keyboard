import 'package:ag_keyboard/src/modules/keyboard/enum/enums.dart';
import 'package:ag_keyboard/src/modules/keyboard/provider/key.press.provider.dart';
import 'package:ag_keyboard/src/modules/keyboard/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../helpers/helpers.dart';
import 'components/layout/numpad.layout.dart';
import 'components/history.board/slidable.history.board.dart';

class AgKeyboard extends ConsumerWidget {
  const AgKeyboard({
    super.key,
    required this.controller,
    this.backgroundColor = Colors.black87,
    this.digitColor = Colors.blue,
    this.operatorColor = Colors.cyan,
    this.backButtonColor,
    this.pointColor = Colors.grey,
    this.resultColor = Colors.grey,
    this.displayColor = Colors.grey,
    this.historyColor,
  });

  final TextEditingController controller;
  final displayHeight = 70.0;
  final Color? backgroundColor,
      digitColor,
      operatorColor,
      backButtonColor,
      pointColor,
      resultColor,
      displayColor,
      historyColor;

  static void onChangeHandler({required String value, required WidgetRef ref}) {
    ref.watch(displayTextProvider.notifier).state = value;
  }

  static void onFieldSubmittedHandler({
    required String value,
    required WidgetRef ref,
    required TextEditingController controller,
    required FocusNode focusNode,
  }) {
    ref.watch(expressionProvider.notifier).state = controller.text;
    calculateResult(ref, controller);
    ref.watch(shouldRecalculateProvider.notifier).state = false;
    focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keyPress = ref.watch(keyPressProvider.notifier);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        DeviceType deviceType = getDeviceType(constraints);
        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
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
                        myText: value,
                        controller: controller,
                      );
                    },
                    onBackspace: () => keyPress.backspace(textController: controller),
                  ),
                ],
              ),
            ),
            if (deviceType == DeviceType.mobile)
              SlidableHistoryBoard(
                historyColor: historyColor,
              ),
          ],
        );
      },
    );
  }

  static String? agValidator(String? value) {
    return checkInuput(value);
  }
}
