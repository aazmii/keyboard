import 'package:flutter/material.dart';
import 'custom_key.dart';

class CustomKeyboard extends StatefulWidget {
  CustomKeyboard({
    super.key,
    this.backgroundColor,
    this.buttonColor,
    this.operatorColor,
    required this.textController,
    required this.focusNode,
  });
  TextEditingController textController;
  final Color? backgroundColor, buttonColor, operatorColor;
  final FocusNode focusNode;

  @override
  State<CustomKeyboard> createState() => _CustomKeyboardState();
}

class _CustomKeyboardState extends State<CustomKeyboard> {
  // final Color agLight = const Color(0xff37B2F3);
  // final Color agDark = const Color(0xff226DC6);
  bool isKeyboardVisible = false;
  final int backspaceIndex = 12;

  void _toggleFocus(BuildContext context) {
    setState(() => isKeyboardVisible = widget.focusNode.hasFocus);
  }

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      _toggleFocus(context);
    });
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(() {
      _toggleFocus(context);
    });
    widget.focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isKeyboardVisible,
      child: Container(
        padding: const EdgeInsets.all(4),
        height: 350,
        color: widget.backgroundColor,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 16,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            childAspectRatio: 5 / 4.5,
          ),
          itemBuilder: (context, index) {
            return index != backspaceIndex
                ? CustomKey(
                    onTextInput: (myText) {
                      _insertText(myText);
                    },
                    text: keyList[index],
                    buttonColor: isOperator(index)
                        ? widget.operatorColor
                        : widget.buttonColor,
                  )
                : CustomKey(
                    onBackspace: () {
                      _backspace();
                    },
                    text: keyList[index],
                    buttonColor: Colors.red,
                  );
          },
        ),
      ),
    );
  }

  void _insertText(String myText) {
    final text = widget.textController.text;
    final textSelection = widget.textController.selection;
    final newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      myText,
    );
    final myTextLength = myText.length;
    widget.textController.text = newText;
    widget.textController.selection = textSelection.copyWith(
      baseOffset: textSelection.start + myTextLength,
      extentOffset: textSelection.start + myTextLength,
    );
  }

  void _backspace() {
    final text = widget.textController.text;
    final textSelection = widget.textController.selection;
    final selectionLength = textSelection.end - textSelection.start;

    // There is a selection.
    if (selectionLength > 0) {
      final newText = text.replaceRange(
        textSelection.start,
        textSelection.end,
        '',
      );
      widget.textController.text = newText;
      widget.textController.selection = textSelection.copyWith(
        baseOffset: textSelection.start,
        extentOffset: textSelection.start,
      );
      return;
    }

    // The cursor is at the beginning.
    if (textSelection.start == 0) {
      return;
    }

    // Delete the previous character
    final previousCodeUnit = text.codeUnitAt(textSelection.start - 1);
    final offset = _isUtf16Surrogate(previousCodeUnit) ? 2 : 1;
    final newStart = textSelection.start - offset;
    final newEnd = textSelection.start;
    final newText = text.replaceRange(
      newStart,
      newEnd,
      '',
    );
    widget.textController.text = newText;
    widget.textController.selection = textSelection.copyWith(
      baseOffset: newStart,
      extentOffset: newStart,
    );
  }

  bool _isUtf16Surrogate(int value) {
    return value & 0xF800 == 0xD800;
  }

  bool isOperator(int index) {
    if (index == 3 || index == 7 || index == 11 || index == 15) {
      return true;
    } else {
      return false;
    }
  }

  //! Order sensetive
  final List<String> keyList = [
    '1',
    '2',
    '3',
    '+',
    '4',
    '5',
    '6',
    '-',
    '7',
    '8',
    '9',
    '*',
    '<',
    '0',
    '.',
    '/',
  ];
}
