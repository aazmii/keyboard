import '../enum/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_expressions/math_expressions.dart';

typedef AGKeyboardNotifier
    = AutoDisposeNotifierProvider<AGKeyboardProvider, void>;

final agKeyboardProvider = AGKeyboardNotifier(AGKeyboardProvider.new);

class AGKeyboardProvider extends AutoDisposeNotifier<void> {
  late String showText;
  late String expText;
  late List<String> history;
  late TextEditingController controller;
  late FocusNode focusNode;
  late bool showHistoryPanel;

  @override
  void build() {
    showText = '';
    expText = '';
    history = [];
    controller = TextEditingController();
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

  _controllerPositionFix() => controller.selection =
      TextSelection.fromPosition(TextPosition(offset: controller.text.length));

  void checkText() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(expText);
      ContextModel cm = ContextModel();
      double value = (exp.evaluate(EvaluationType.REAL, cm));
      if (value == value.toInt()) {
        final r = value.toInt().toString();
        debugPrint('New Text toInt(): $r');
        history.add('$showText=$r');
        showText = r;
        controller.text = r;
        _controllerPositionFix();
        expText = r;
        ref.notifyListeners();
      } else {
        final r = value.toStringAsFixed(3);
        debugPrint('New Text toStringAsFixed(3): $r');
        history.add('$showText=$r');
        showText = r;
        controller.text = r;
        _controllerPositionFix();
        expText = r;
        ref.notifyListeners();
      }
    } catch (e) {
      print('Can\'t evaluate: $e');
    }
  }

  void pressKey(CalcKey calcKey, [bool isLongPress = false]) {
    debugPrint('pressKey: ${calcKey.char}');
    if (calcKey == CalcKey.backSpace) {
      if (isLongPress) {
        controller.text = '';
        _controllerPositionFix();
        showText = '';
        expText = '';
      } else {
        if (showText.isEmpty) return;
        if (expText.isEmpty) return;
        final newText = showText.substring(0, showText.length - 1);
        final newExp = expText.substring(0, expText.length - 1);
        showText = newText;
        expText = newExp;
        controller.text = newText;
        _controllerPositionFix();
      }
      ref.notifyListeners();
      return;
    } else if (calcKey == CalcKey.equalKey) {
      checkText();
      ref.notifyListeners();
      return;
    }
    showText += calcKey.char;
    expText += calcKey.val;
    controller.text = showText;
    _controllerPositionFix();
    ref.notifyListeners();
  }
}
