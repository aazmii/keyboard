import 'package:ag_keyboard/src/modules/keyboard/provider/helper.dart';
import 'package:ag_keyboard/src/modules/keyboard/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KeyPressProvider extends Notifier<KeyPressProvider> {
  String lastOperator = '';
  String lastChar = '';
  int numOfPoint = 0;
  void insertText({
    required String myText,
    required WidgetRef ref,
    required TextEditingController controller,
  }) {
    bool repeat = ref.watch(shouldRecalculateProvider);
    if (repeat) {
      if (!isOperator(myText)) {
        controller.clear();
        ref.read(displayTextProvider.notifier).state = '';
        ref.watch(shouldRecalculateProvider.notifier).state = false;
        ref.watch(expressionProvider.notifier).state = '';
      } else {
        ref.watch(shouldRecalculateProvider.notifier).state = false;
        ref.watch(displayTextProvider.notifier).state =
            '${ref.watch(expressionProvider.notifier).state} ${ref.watch(resultProvider.notifier).state}';
      }
    }
    //first char cant be operator except (-)
    if (controller.text.isEmpty) {
      numOfPoint = 0;
      ref.watch(expressionProvider.notifier).state += myText;

      if (myText == '.') {
        numOfPoint++;
      }
      if (myText != '-') if (isOperator(myText)) return;
    } else {
      lastChar = controller.text[controller.text.length - 1];
      if (myText == '.') {
        numOfPoint++;
      }

      if (isOperator(lastChar) && isOperator(myText)) {
        final text = ref.watch(expressionProvider.notifier).state;

        numOfPoint = 0;
        ref.watch(expressionProvider.notifier).state =
            text.substring(0, text.length - 1);
        //replace
        backspace(textController: controller, ref: ref);
      }
    }
    if (isOperator(myText)) {
      numOfPoint = 0;
    }
    if (numOfPoint >= 2) {
      if (myText == '.') return;
    }

    final text = controller.text;
    final textSelection = controller.selection;
    final newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      myText,
    );

    final myTextLength = myText.length;
    controller.text = newText;

    ref
        .read(displayTextProvider.notifier)
        .update((state) => state = controller.text);
    ref
        .read(expressionProvider.notifier)
        .update((state) => state = controller.text);

    controller.selection = textSelection.copyWith(
      baseOffset: textSelection.start + myTextLength,
      extentOffset: textSelection.start + myTextLength,
    );
  }

  void backspace(
      {required TextEditingController textController, required WidgetRef ref}) {
    final text = textController.text;
    final textSelection = textController.selection;
    final selectionLength = textSelection.end - textSelection.start;
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
    ref.read(expressionProvider.notifier).state = newText;

    textController.selection = textSelection.copyWith(
      baseOffset: newStart,
      extentOffset: newStart,
    );
  }

  @override
  KeyPressProvider build() {
    return KeyPressProvider();
  }
}
