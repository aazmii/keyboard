import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../enum/enums.dart';

NumberFormat bdtNumberFormat = NumberFormat('#,##,##0.0#');

String textFormat(String text, NumberFormat format) {
  debugPrint('My Text: $text');
  String str = text;
  // str = changeToCalcVal(text);
  // 123456789 + 987654321 = 1,111,111,110
  final delimeters =
      CalcKey.values.where((e) => e.isOperator).map((e) => e.val).toList();
  debugPrint('Fixed Delimar: $delimeters');
  // final delimeters = ['+', '-', '*', '/', '='];
  str = replaceDelimar(text, delimeters, 'z');
  print('After Replace Delimar with z: $str');
  List<String> digits = str.split('z');
  print('Digits After Spliting: $digits');
  List<String> temp = [];
  for (var e in digits) {
    if (e == '') continue;
    temp.add(format.format(double.parse(e)));
  }
  digits = [...temp];
  print('After Format: $digits');
  final concat = digits.length == 1
      ? str[0] == 'z'
          ? 'z${digits[0]}'
          : str[str.length - 1] == 'z'
              ? '${digits[0]}z'
              : digits.join('z')
      : digits.join('z');
  print('After Concat: $concat');
  final List<String> operators = getOperatorList(text);
  print('Operators: $operators');
  str = replaceDelimarReverse(concat, operators, 'z');
  print('After Replace z with Delimar: $str');
  print('====================================');
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
