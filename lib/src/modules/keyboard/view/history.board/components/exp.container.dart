import 'package:flutter/material.dart';

class ExpressionContainer extends StatelessWidget {
  const ExpressionContainer({super.key, required this.expression});
  final String expression;

  @override
  Widget build(BuildContext context) {
    final slplittedList = expression.split('=');
    final exp = slplittedList[0];
    final res = slplittedList[1];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          exp,
          textAlign: TextAlign.right,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '= $res',
          style: const TextStyle(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
