import 'package:ag_keyboard/src/extensions/extensions.dart';
import 'package:ag_keyboard/src/modules/keyboard/const/device.info.dart';
import 'package:ag_keyboard/src/modules/keyboard/const/enums.dart';
import 'package:ag_keyboard/src/modules/keyboard/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../const/exp.dart';

DeviceType getDeviceType(BoxConstraints constraints) {
  double height = constraints.maxHeight;
  double width = constraints.maxWidth;
  if (width <= maxMobileWidth && height <= maxMobileHeight) {
    return DeviceType.mobile;
  } else if (width <= tabletWidth && height <= tabletHight) {
    return DeviceType.tablet;
  } else {
    return DeviceType.desktop;
  }
}

bool isOperator(String char) {
  if (char == '+' || char == '-' || char == '*' || char == '/') {
    return true;
  } else {
    return false;
  }
}

//return true if any operator found
bool containsOperator(String exp) {
  if (exp.contains('+')) return true;
  if (exp.contains('-')) return true;
  if (exp.contains('*')) return true;
  if (exp.contains('/')) return true;
  return false;
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
  if (!containsOperator(controller.text)) return;

  if (!formKey.currentState!.validate()) return;
  if (isOperator(controller.text[controller.text.length - 1])) return;
  //if no operator

  try {
    res = ref
        .read(resultProvider.notifier)
        .getResult(expression: controller.text);
  } catch (e) {
    ref.watch(shouldRecalculateProvider.notifier).state = true;
    // ref.watch(displayTextProvider.notifier).state = '';
    ref.watch(expressionProvider.notifier).state = '';
    return;
  }
  ref.read(displayTextProvider.notifier).state += '=$res,';
  ref.watch(expressionProvider.notifier).state += '=$res';
  //insert into history
  ref.watch(historyProvider.notifier).update(
      (state) => [ref.read(expressionProvider.notifier).state, ...state]);
  //make ready for next expression
  ref.watch(expressionProvider.notifier).state = res;
  ref.read(displayTextProvider.notifier).state = '';
  ref.watch(shouldRecalculateProvider.notifier).state = true;
  controller.text = res;
  controller.selection = TextSelection.fromPosition(
    TextPosition(offset: controller.text.length),
  );
}
