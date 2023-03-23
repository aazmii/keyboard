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

  // onChanged(String? v) {
  //   if (v == null) return;
  //   focusNode.requestFocus();
  //   print('Controller onChanged Text: $v');
  //   final lc = v[v.length - 1];
  //   if (lc == '=') {
  //     controller.text =
  //         controller.text.substring(0, controller.text.length - 1);
  //     checkText();
  //   } else if (getCalcKeyByVal(lc) != null) {
  //     controller.text =
  //         controller.text.substring(0, controller.text.length - 1);
  //     pressKey(getCalcKeyByVal(lc)!);
  //   } else {
  //     controller.text =
  //         controller.text.substring(0, controller.text.length - 1);
  //     ref.notifyListeners();
  //   }
  // }

  lisentener() => controller.addListener(() {
        // final text = controller.text;
        // print('Controller Listener Text: $text');
        // final len = text.length;
        // print('Controller text length: $len');
        // final lastChar = len < 1 ? null : text[len - 1];
        // print('Last Char: $lastChar');
        // print('=============================');
        // if (lastChar != null) {
        //   print('Character is not null');
        //   final calcKey = getCalcKeyByVal(lastChar);
        //   if (calcKey == null) {
        //     print('Invalid key');
        //     controller.text =
        //         controller.text.substring(0, controller.text.length - 1);
        //     _controllerPositionFix();
        //     // ref.notifyListeners();
        //   } else if (calcKey == CalcKey.equalKey) {
        //     print('CalcKey Press: $calcKey');
        //     controller.text =
        //         controller.text.substring(0, controller.text.length - 1);
        //     _controllerPositionFix();
        //     checkText();
        //   } else {
        //     print('CalcKey Press: $calcKey');
        //   }
        //   print('>>>>>>>>>>>><<<<<<<<<<<');
        //   // else {
        //   //   controller.text =
        //   //       controller.text.substring(0, controller.text.length - 1);
        //   //   _controllerPositionFix();
        //   //   pressKey(calcKey);
        //   // }
        //   // if (getCalcKeyByVal(lastChar) != null) {
        //   //   controller.text =
        //   //       controller.text.substring(0, controller.text.length - 1);
        //   //   pressKey(getCalcKeyByVal(lastChar)!);
        //   // } else if (lastChar == '=') {
        //   //   controller.text =
        //   //       controller.text.substring(0, controller.text.length - 1);
        //   //   checkText();
        //   // } else {
        //   //   controller.text =
        //   //       controller.text.substring(0, controller.text.length - 1);
        //   // }
        //   // ref.notifyListeners();
        // } else {
        //   print('Character is null');
        //   // ref.notifyListeners();
        // }
        // // final txt = controller.text;
        // // print('Controller Listener Text: $txt');
        // // if (txt.isNotEmpty && txt != '') {
        // //   final lc = txt[txt.length - 1];
        // //   if (lc == '=') {
        // //     controller.text =
        // //         controller.text.substring(0, controller.text.length - 1);
        // //     checkText();
        // //   } else if (getCalcKeyByVal(lc) != null) {
        // //     controller.text =
        // //         controller.text.substring(0, controller.text.length - 1);
        // //     pressKey(getCalcKeyByVal(lc)!);
        // //   } else {
        // //     controller.text =
        // //         controller.text.substring(0, controller.text.length - 1);
        // //   }
        // // }
        // // showText = controller.text;
        // // expText = controller.text;
        // // ref.notifyListeners();
      });

  _controllerPositionFix([int? p]) =>
      controller.selection = TextSelection.fromPosition(
          TextPosition(offset: p ?? controller.text.length));

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
    // debugPrint('pressKey: ${calcKey.char}');
    int p = controller.selection.baseOffset;
    // print('Cursor Position: $p');
    if (calcKey == CalcKey.backSpace) {
      if (isLongPress) {
        controller.text = '';
        _controllerPositionFix();
        showText = '';
        expText = '';
      } else {
        if (showText.isEmpty) return;
        if (expText.isEmpty) return;
        final newText = showText.replaceRange(p - 1, p, '');
        final newExp = expText.replaceRange(p - 1, p, '');
        showText = newText;
        expText = newExp;
        controller.text = newText;
        _controllerPositionFix(p - 1);
      }
      ref.notifyListeners();
      return;
    } else if (calcKey == CalcKey.equalKey) {
      checkText();
      ref.notifyListeners();
      return;
    }
    if (history.isNotEmpty &&
        history.last.split('=').last == showText &&
        !calcKey.isOperator) {
      debugPrint('Clear History');
      controller.text = '';
      showText = '';
      expText = '';
      _controllerPositionFix(0);
      p = 0;
    }
    if (p == showText.length) {
      showText += calcKey.char;
      expText += calcKey.val;
      controller.text = showText;
      _controllerPositionFix();
    } else {
      showText = showText == ''
          ? showText
          : '${showText.substring(0, p)}${calcKey.char}${showText.substring(p, showText.length)}';
      expText = expText == ''
          ? expText
          : '${expText.substring(0, p)}${calcKey.val}${expText.substring(p, expText.length)}';
      controller.text = showText;
      _controllerPositionFix(p + 1);
    }
    ref.notifyListeners();
  }
}
