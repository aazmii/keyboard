import 'package:flutter/services.dart';

TextInputFormatter createInputFormatter(List<String> allowedChars) {
  // debugPrint('allowedChars: $allowedChars');
  // allowedChars: []'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '-', '*', '/']
  final allowedCharsPattern = allowedChars.map((char) {
    if (char == '-') return '\\-';
    return RegExp.escape(char);
  }).join('|');
  final allowedCharsRegex = RegExp('[$allowedCharsPattern]+');
  // debugPrint('allowedCharsRegex: $allowedCharsRegex');
  return FilteringTextInputFormatter.allow(allowedCharsRegex);
}
