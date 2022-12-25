import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_expressions/math_expressions.dart';

final controllerProvier = Provider.autoDispose<TextEditingController>((ref) {
  final textController = TextEditingController();
  ref.onDispose(() => textController.dispose());
  return textController;
});
final displayTextProvider = StateProvider.autoDispose<String>((ref) => '');
final shouldRecalculateProvider =
    StateProvider.autoDispose<bool>((ref) => false);

final resultProvider =
    NotifierProvider<ResultProvider, String>(ResultProvider.new);

//provides result
class ResultProvider extends Notifier<String> {
  String result = '';
  String getResult({String expression = ''}) {
    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      result = '${exp.evaluate(EvaluationType.REAL, cm)}';
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  @override
  String build() {
    return result;
  }
}

// final displayTextProvider =
//     NotifierProvider<DiaplayTextProvider, String>(DiaplayTextProvider.new);

// class DiaplayTextProvider extends Notifier<String> {
//   String displayText = '';

//   @override
//   String build() {
//     return displayText;
//   }
// }
