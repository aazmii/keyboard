import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../enum/enums.dart';

NumberFormat bdtNumberFormat = NumberFormat('#,##,##0.0#');

String textFormat(String text, NumberFormat format, [bool isDebug = false, String delimar = 'z']) {
  if (isDebug)  debugPrint('My Text: $text');
  String str = text;
  // str = changeToCalcVal(text);
  // 123456789 + 987654321 = 1,111,111,110
  final delimeters =
      CalcKey.values.where((e) => e.isOperator).map((e) => e.val).toList();
  if (isDebug) debugPrint('Fixed Delimar: $delimeters');
  // final delimeters = ['+', '-', '*', '/', '='];
  str = replaceDelimar(text, delimeters, delimar);
  if (isDebug) debugPrint('After Replace Delimar with $delimar: $str');
  List<String> digits = str.split(delimar);
  if (isDebug) debugPrint('Digits After Spliting: $digits');
  List<String> temp = [];
  for (final e in digits) {
    if (e == '') continue;
    temp.add(format.format(double.parse(e)));
  }
  digits = [...temp];
  if (isDebug) debugPrint('After Format: $digits');
  final concat = digits.length == 1
      ? str[0] == delimar
          ? '$delimar${digits[0]}'
          : str[str.length - 1] == delimar
              ? '${digits[0]}$delimar'
              : digits.join(delimar)
      : digits.join(delimar);
  if (isDebug) debugPrint('After Concat: $concat');
  final operators = getOperatorList(text);
  if (isDebug) debugPrint('Operators: $operators');
  str = replaceDelimarReverse(concat, operators, delimar);
  if (isDebug) debugPrint('After Replace $delimar with Delimar: $str');
  if (isDebug) debugPrint('====================================');
  return str;
}

List<String> getOperatorList(String str) {
  List<String> list = [];
  final delimeters =
      CalcKey.values.where((e) => e.isOperator).map((e) => e.val).toList();
  for (int i = 0; i < str.length; i++) {
    if (delimeters.contains(str[i])) list.add(str[i]);
  }
  return list;
}

// String changeToCalcVal(String text) {
//   String str = text;
//   for (var rune in str.runes) {
//     CalcKey? character = getCalcKeyByVal(String.fromCharCode(rune));
//     if (character != null) {
//       str = str.replaceFirst(String.fromCharCode(rune), character.val);
//     }
//     print(character);
//   }
//   return str;
// }

String replaceDelimar(String text, List<String> delimeters, String r) {
  String str = text;

  for (int i = 0; i < str.length; i++) {
    if (delimeters.contains(str[i])) str = str.replaceFirst(str[i], r);
  }
  return str;
}

String replaceDelimarReverse(String text, List<String> delimeters, String r) {
  String str = text;
  int d = 0;

  for (int i = 0; i < str.length; i++) {
    if (r == str[i]) {
      str = str.replaceFirst(str[i], getCalcKeyByVal(delimeters[d])!.char);
      d += 1;
    }
  }
  return str;
}
