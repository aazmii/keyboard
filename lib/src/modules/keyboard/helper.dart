import 'package:ag_keyboard/src/modules/keyboard/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'history.dart';

bool isOperator(String char) {
  if (char == '+' || char == '-' || char == '*' || char == '/') {
    return true;
  } else {
    return false;
  }
}

String? checkInuput(String? value) {
  String? char;
  if (value!.isEmpty) return '';
  char = value.substring(value.length - 1);

  if (!isOperator(char)) {
    if (char == '.') {
      return null;
    } else {
      try {
        double.parse(char);
      } on FormatException {
        char = '';
        return '';
      }
      char = '';
      return null;
    }
  } else {
    char = '';
    return null;
  }
}

calculateResult(WidgetRef ref, TextEditingController controller) {
  bool reClculate = ref.watch(shouldRecalculateProvider);
  final formKey = ref.watch(formKeyProvider);
  String res = '';
  if (reClculate) return;
  // if (controller.text.isEmpty) return;
  if (!formKey.currentState!.validate()) return;
  if (isOperator(controller.text[controller.text.length - 1])) return;
  try {
    res = ref
        .read(resultProvider.notifier)
        .getResult(expression: controller.text);
  } catch (e) {
    ref.watch(shouldRecalculateProvider.notifier).state = true;
    ref.watch(displayTextProvider.notifier).state = '';
    ref.watch(expressionProvider.notifier).state = '';
  }
  ref.read(displayTextProvider.notifier).state += '=$res';

  ref.watch(expressionProvider.notifier).state += '=$res';
  History.history.add(ref.read(expressionProvider.notifier).state);
  //make ready for next expression
  ref.watch(expressionProvider.notifier).state = res;

  ref.watch(shouldRecalculateProvider.notifier).state = true;
  controller.text = res;
  controller.selection = TextSelection.fromPosition(
    TextPosition(offset: controller.text.length),
  );

  print(History.history);
}
