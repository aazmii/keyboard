import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_expressions/math_expressions.dart';

class ResultProvider extends Notifier<String> {
  String result = '';
  String getResult({String expression = ''}) {
    Parser p = Parser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();
    double value = (exp.evaluate(EvaluationType.REAL, cm));
    if (value == value.toInt()) {
      result = value.toInt().toString();
    } else {
      result = value.toStringAsFixed(3);
    }

    return result;
  }

  @override
  String build() {
    return result;
  }
}
