import 'package:ag_keyboard/src/modules/keyboard/provider/calculation.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KeyboardLogic {
  static void insertText(
      {required String myText,
      required WidgetRef ref,
      required TextEditingController textController}) {
    // bool recalculate = ref.read(calculationProvider).shouldRecalculate;
    bool recalculate = ref.read(shouldRecalculateProvider);

    if (recalculate) {
      textController.clear();
      // ref.watch(calculationProvider).shouldRecalculate = false;
      ref.read(shouldRecalculateProvider.notifier).state = false;
    }
    final text = textController.text;
    final textSelection = textController.selection;
    final newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      myText,
    );
    final myTextLength = myText.length;
    textController.text = newText;
    textController.selection = textSelection.copyWith(
      baseOffset: textSelection.start + myTextLength,
      extentOffset: textSelection.start + myTextLength,
    );
  }

  static void backspace({required TextEditingController textController}) {
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
      textController.text = newText;
      textController.selection = textSelection.copyWith(
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
    final offset = isUtf16Surrogate(previousCodeUnit) ? 2 : 1;
    final newStart = textSelection.start - offset;
    final newEnd = textSelection.start;
    final newText = text.replaceRange(
      newStart,
      newEnd,
      '',
    );
    textController.text = newText;
    textController.selection = textSelection.copyWith(
      baseOffset: newStart,
      extentOffset: newStart,
    );
  }
}
