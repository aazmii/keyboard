import 'package:ag_keyboard/src/modules/keyboard/const/enums.dart';
import 'package:flutter/material.dart';

import 'components/custom_key.dart';
import 'components/result.button.dart';

class KeyboardLayout extends StatelessWidget {
  const KeyboardLayout({
    required this.onTextInput,
    required this.textController,
    required this.onBackspace,
    super.key,
    this.digitColor,
    this.operatorColor,
    this.backButtonColor,
    this.pointColor,
    this.resultColor,
  });

  final Color? digitColor,
      operatorColor,
      backButtonColor,
      pointColor,
      resultColor;
  final TextEditingController textController;
  final ValueSetter<String>? onTextInput;
  final VoidCallback? onBackspace;

  void _textInputHandler(String text) => onTextInput!.call(text);
  void _backspaceHandler() => onBackspace!.call();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                flex: 5,
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getFlexCol1(),
                      const SizedBox(width: 1),
                      getFlexCol2(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CustomKey(
                calcKey: CalcKey.zero,
                onTextInput: _textInputHandler,
                buttonColor: digitColor,
              ),
            ],
          ),
        ),
        getFlexColumn3(),
        getFlexCol4(),
      ],
    );
  }

  SizedBox getFlexCol1() => SizedBox(
        width: 80,
        child: Column(
          children: [
            CustomKey(
              calcKey: CalcKey.one,
              onBackspace: _backspaceHandler,
              buttonColor: backButtonColor,
            ),
            const SizedBox(height: 10),
            CustomKey(
              calcKey: CalcKey.one,
              onTextInput: _textInputHandler,
              buttonColor: digitColor,
            ),
            const SizedBox(height: 10),
            CustomKey(
              calcKey: CalcKey.four,
              onTextInput: _textInputHandler,
              buttonColor: digitColor,
            ),
            const SizedBox(height: 10),
            CustomKey(
              calcKey: CalcKey.seven,
              onTextInput: _textInputHandler,
              buttonColor: digitColor,
            ),
          ],
        ),
      );
  SizedBox getFlexCol2() => SizedBox(
        width: 80,
        child: Column(
          children: [
            CustomKey(
              calcKey: CalcKey.division,
              onTextInput: _textInputHandler,
              buttonColor: operatorColor,
            ),
            const SizedBox(height: 10),
            CustomKey(
              calcKey: CalcKey.two,
              onTextInput: _textInputHandler,
              buttonColor: digitColor,
            ),
            const SizedBox(height: 10),
            CustomKey(
              calcKey: CalcKey.five,
              onTextInput: _textInputHandler,
              buttonColor: digitColor,
            ),
            const SizedBox(height: 10),
            CustomKey(
              calcKey: CalcKey.eight,
              onTextInput: _textInputHandler,
              buttonColor: digitColor,
            ),
          ],
        ),
      );

  SizedBox getFlexCol4() {
    return SizedBox(
      width: 80,
      child: Column(
        children: [
          CustomKey(
            calcKey: CalcKey.substract,
            onTextInput: _textInputHandler,
            buttonColor: operatorColor,
          ),
          const SizedBox(height: 10),
          CustomKey(
            calcKey: CalcKey.add,
            onTextInput: _textInputHandler,
            flex: 2,
            buttonColor: operatorColor,
          ),
          const SizedBox(height: 10),
          ResultButton(
            controller: textController,
            flex: 2,
            buttonColor: resultColor,
          )
        ],
      ),
    );
  }

  SizedBox getFlexColumn3() {
    return SizedBox(
      width: 80,
      child: Column(
        children: [
          CustomKey(
            calcKey: CalcKey.multiply,
            onTextInput: _textInputHandler,
            buttonColor: operatorColor,
          ),
          const SizedBox(height: 10),
          CustomKey(
            calcKey: CalcKey.three,
            onTextInput: _textInputHandler,
            buttonColor: digitColor,
          ),
          const SizedBox(height: 10),
          CustomKey(
            calcKey: CalcKey.six,
            onTextInput: _textInputHandler,
            buttonColor: digitColor,
          ),
          const SizedBox(height: 10),
          CustomKey(
            calcKey: CalcKey.nine,
            onTextInput: _textInputHandler,
            buttonColor: digitColor,
          ),
          const SizedBox(height: 10),
          CustomKey(
            calcKey: CalcKey.point,
            onTextInput: _textInputHandler,
            buttonColor: pointColor,
          ),
        ],
      ),
    );
  }
}
