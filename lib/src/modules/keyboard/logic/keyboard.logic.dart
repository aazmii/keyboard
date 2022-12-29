import 'package:ag_keyboard/src/modules/keyboard/provider/calculation.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//! ATTENTION: changing here anything mmight cost another 40 minutes of work to fix

class KeyboardLogic {
  String lastOperator = '';
  String lastChar = '';
  int numOfPoint = 0; // each number can not contain more than one point

  bool isOperator(String char) {
    if (char == '+' || char == '-' || char == '*' || char == '/') {
      return true;
    } else {
      return false;
    }
  }

  void insertText({
    required String myText,
    required WidgetRef ref,
    required TextEditingController ted,
  }) {
    print(numOfPoint);
    numOfPoint++;
    print(numOfPoint);
    bool recalculate = ref.read(shouldRecalculateProvider);

    if (recalculate) {
      if (!isOperator(myText)) {
        ted.clear();
        ref.read(shouldRecalculateProvider.notifier).state = false;
        ref.read(displayTextProvider.notifier).state = '';
      } else {
        ref.read(shouldRecalculateProvider.notifier).state = false;
      }
    }
    //first char cant be operator except (-)
    if (ted.text.isEmpty) {
      if (myText == '.') {
        // numOfPoint++;
      }

      if (myText != '-') if (isOperator(myText)) return;
    } else {
      lastChar = ted.text[ted.text.length - 1];
      if (myText == '.') {
        // numOfPoint += 1;
      }
      if (isOperator(lastChar) && isOperator(myText)) {
        // not more than one point allowed for each numer
        // numOfPoint = 0;
        backspace(textController: ted, ref: ref);
      }
    }

    final text = ted.text;
    final textSelection = ted.selection;
    final newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      myText,
    );
    ref.read(displayTextProvider.notifier).state += newText[newText.length - 1];
    final myTextLength = myText.length;
    ted.text = newText;

    ted.selection = textSelection.copyWith(
      baseOffset: textSelection.start + myTextLength,
      extentOffset: textSelection.start + myTextLength,
    );
  }

  static void backspace(
      {required TextEditingController textController, required WidgetRef ref}) {
    final text = textController.text;
    final textSelection = textController.selection;
    final selectionLength = textSelection.end - textSelection.start;
    // if (ref.watch(shouldRecalculateProvider)) return;
    bool isUtf16Surrogate(int value) {
      return value & 0xF800 == 0xD800;
    }

    // There is a selection.
    if (selectionLength > 0) {
      final newText = text.replaceRange(
        textSelection.start,
        textSelection.end,
        '',
      );
      ref.read(displayTextProvider.notifier).state = '';
      textController.text = newText;
      textController.selection = textSelection.copyWith(
        baseOffset: textSelection.start,
        extentOffset: textSelection.start,
      );
      ref.read(displayTextProvider.notifier).state = textController.text;

      return;
    }
    // The cursor is at the beginning.
    if (textSelection.start == 0) {
      return;
    }
    // Delete the previous character
    final previousCodeUnit = text.codeUnitAt(textSelection.start - 1);
    final offset = isUtf16Surrogate(previousCodeUnit) ? 2 : 1;
    final newStart = textSelection.start - offset;
    final newEnd = textSelection.start;
    final newText = text.replaceRange(
      newStart,
      newEnd,
      '',
    );
    textController.text = newText;
    ref.read(displayTextProvider.notifier).state = newText;

    textController.selection = textSelection.copyWith(
      baseOffset: newStart,
      extentOffset: newStart,
    );
  }
}
