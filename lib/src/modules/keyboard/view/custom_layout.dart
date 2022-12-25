import 'package:flutter/material.dart';

import 'custom_key.dart';

class CustomLayout extends StatelessWidget {
  const CustomLayout({
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
  final TextEditingController textController; //TODO: pass it to equal button
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
                dispayText: '0',
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
              onBackspace: _backspaceHandler,
              dispayText: '<',
              buttonColor: backButtonColor,
            ),
            const SizedBox(height: 10),
            CustomKey(
              dispayText: '1',
              charList: const ['_'],
              onTextInput: _textInputHandler,
              buttonColor: digitColor,
            ),
            const SizedBox(height: 10),
            CustomKey(
              dispayText: '4',
              charList: const ['g', 'h', 'i'],
              onTextInput: _textInputHandler,
              buttonColor: digitColor,
            ),
            const SizedBox(height: 10),
            CustomKey(
              dispayText: '7',
              charList: const ['p', 'q', 'r', 's'],
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
              dispayText: '/',
              onTextInput: _textInputHandler,
              buttonColor: operatorColor,
            ),
            const SizedBox(height: 10),
            CustomKey(
              dispayText: '2',
              charList: const ['a', 'b', 'c'],
              onTextInput: _textInputHandler,
              buttonColor: digitColor,
            ),
            const SizedBox(height: 10),
            CustomKey(
              dispayText: '5',
              charList: const ['j', 'k', 'l'],
              onTextInput: _textInputHandler,
              buttonColor: digitColor,
            ),
            const SizedBox(height: 10),
            CustomKey(
              dispayText: '8',
              charList: const ['t', 'u', 'v'],
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
            dispayText: '-',
            onTextInput: _textInputHandler,
            buttonColor: operatorColor,
          ),
          const SizedBox(height: 10),
          CustomKey(
            dispayText: '+',
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
            dispayText: '*',
            onTextInput: _textInputHandler,
            buttonColor: operatorColor,
          ),
          const SizedBox(height: 10),
          CustomKey(
            dispayText: '3',
            charList: const ['d', 'e', 'f'],
            onTextInput: _textInputHandler,
            buttonColor: digitColor,
          ),
          const SizedBox(height: 10),
          CustomKey(
            dispayText: '6',
            charList: const ['m', 'n', 'o'],
            onTextInput: _textInputHandler,
            buttonColor: digitColor,
          ),
          const SizedBox(height: 10),
          CustomKey(
            dispayText: '9',
            charList: const ['w', 'x', 'y', 'z'],
            onTextInput: _textInputHandler,
            buttonColor: digitColor,
          ),
          const SizedBox(height: 10),
          CustomKey(
            dispayText: '.',
            onTextInput: _textInputHandler,
            buttonColor: pointColor,
          ),
        ],
      ),
    );
  }
}
