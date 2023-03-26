import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_expressions/math_expressions.dart';

import '../enum/enums.dart';

typedef AGKeyboardNotifier
    = AutoDisposeNotifierProviderFamily<AGKeyboardProvider, void, String?>;

final agKeyboardProvider = AGKeyboardNotifier(AGKeyboardProvider.new);

class AGKeyboardProvider extends AutoDisposeFamilyNotifier<void, String?> {
  late String showText;
  late String expText;
  late List<String> history;
  late TextEditingController controller;
  late FocusNode focusNode;
  late bool showHistoryPanel;

  @override
  void build(String? arg) {
    showText = arg ?? '';
    expText = arg ?? '';
    history = [];
    controller = TextEditingController(text: arg);
    focusNode = FocusNode();
    showHistoryPanel = false;
    return;
  }

  toggleHistoryPanel() {
    showHistoryPanel = !showHistoryPanel;
    ref.notifyListeners();
  }

  clearHistory() {
    history.clear();
    toggleHistoryPanel();
    ref.notifyListeners();
  }

  lisentener([bool isDebug = false]) => controller.addListener(() {
        final text = controller.text;
        if (isDebug) debugPrint('Controller Listener Text: $text');
        final len = text.length;
        if (isDebug) debugPrint('Controller text length: $len');
        final lastChar = len < 1 ? null : text[len - 1];
        if (isDebug) debugPrint('Last Char: $lastChar');
        if (isDebug) debugPrint('=============================');
        if (len != 0) {
          if (isDebug) debugPrint('Text without last char: ${text.substring(0, text.length - 1)}');
          if (history.isNotEmpty && history.last.split('=').last == text.substring(0, text.length - 1) && lastChar != null && !getCalcKeyByVal(lastChar)!.isOperator) {
            if (isDebug) debugPrint('Clear History');
            controller.text = text[text.length - 1];
            showText = text[text.length - 1];
            expText = text[text.length - 1];
            _controllerPositionFix(1);
          } else {
            showText = convertToShowText(text);
            expText = convertToExp(text);
          }
          ref.notifyListeners();
          return;
        } else {
          showText = '';
          expText = '';
          ref.notifyListeners();
          return;
        }
      });

  _controllerPositionFix([int? p]) =>
      controller.selection = TextSelection.fromPosition(TextPosition(offset: p ?? controller.text.length));

  void pressKey(BuildContext context, CalcKey calcKey,
      [bool isLongPress = false, bool isDebug = false]) {
    if (isDebug) debugPrint('pressKey: ${calcKey.char}');
    int p = controller.selection.baseOffset;
    if (isDebug)  debugPrint('Cursor Position: $p');
    if (calcKey == CalcKey.backSpace) {
      if (isLongPress) {
        controller.text = '';
      } else {
        if (controller.text.isEmpty) return;
        final newText = controller.text.replaceRange(p - 1, p, '');
        controller.text = newText;
        _controllerPositionFix(p - 1);
      }
      ref.notifyListeners();
      return;
    } else if (calcKey == CalcKey.equalKey) {
      checkText(context, isDebug);
      return;
    } else {
      //
      if (p == controller.text.length) {
        controller.text += calcKey.char;
        _controllerPositionFix();
      } else {
        controller.text = controller.text == ''
            ? controller.text
            : '${controller.text.substring(0, p)}${calcKey.char}${controller.text.substring(p, controller.text.length)}';
        _controllerPositionFix(p + 1);
      }
    }
    FocusScope.of(context).requestFocus(focusNode);
  }

  void checkText(BuildContext context, [bool isDebug = false]) {
    if (isDebug) debugPrint('checkText: $expText');
    try {
      Parser p = Parser();
      Expression exp = p.parse(expText);
      ContextModel cm = ContextModel();
      double value = (exp.evaluate(EvaluationType.REAL, cm));
      if (value == value.toInt()) {
        final r = value.toInt().toString();
        if (isDebug) debugPrint('New Text toInt(): $r');
        history.add('$showText=$r');
        showText = r;
        controller.text = r;
        _controllerPositionFix();
        expText = r;
        FocusScope.of(context).requestFocus(focusNode);
        ref.notifyListeners();
        return;
      } else {
        final r = value.toStringAsFixed(3);
        if (isDebug) debugPrint('New Text toStringAsFixed(3): $r');
        history.add('$showText=$r');
        showText = r;
        controller.text = r;
        _controllerPositionFix();
        expText = r;
        FocusScope.of(context).requestFocus(focusNode);
        ref.notifyListeners();
        return;
      }
    } catch (e) {
      debugPrint('Can\'t evaluate: $e');
      return;
    }
  }
}
