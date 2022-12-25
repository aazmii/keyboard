import 'package:ag_keyboard/src/modules/keyboard/logic/keyboard.logic.dart';
import 'package:ag_keyboard/src/modules/keyboard/provider/calculation.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'custom_layout.dart';

class AgKeyboard extends ConsumerWidget {
  const AgKeyboard({
    super.key,
    this.backgroundColor,
    this.digitColor = Colors.blue,
    this.operatorColor = Colors.cyan,
    required this.textController,
    required this.focusNode,
    this.backButtonColor = Colors.red,
    this.pointColor = Colors.grey,
    this.resultColor = Colors.cyan,
    this.displayColor = Colors.grey,
  });

  final TextEditingController textController;
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
      child: _buildKeyboard(context),
    );
  }

  Column _buildKeyboard(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextField(
          style: Theme.of(context).textTheme.headlineMedium,
          keyboardType: TextInputType.none,
          controller: textController,
          autofocus: false,
          decoration: _displayDecoration(),
          showCursor: true,
        ),
        Container(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          height: 350,
          color: backgroundColor,
          child: Consumer(
            builder: (context, ref, child) {
              return CustomLayout(
                  onTextInput: (myText) {
                    KeyboardLogic.insertText(
                        myText: myText,
                        ref: ref,
                        textController: textController);
                  },
                  onBackspace: () {
                    ref.watch(shouldRecalculateProvider)
                        ? null
                        : KeyboardLogic.backspace(
                            textController: textController);
                  },
                  digitColor: digitColor,
                  operatorColor: operatorColor,
                  pointColor: pointColor,
                  backButtonColor: backButtonColor,
                  resultColor: resultColor,
                  textController: textController);
            },
          ),
        )
      ],
    );
  }

  InputDecoration _displayDecoration() => InputDecoration(
        fillColor: displayColor!.withOpacity(0.3),
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 12,
        ),
        border: InputBorder.none,
      );
}
