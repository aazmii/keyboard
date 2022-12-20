import 'package:flutter/material.dart';

class CustomKey extends StatelessWidget {
  const CustomKey({
    Key? key,
    required this.text,
    this.onTextInput,
    this.buttonColor,
    this.buttonSize = 24,
    this.onBackspace,
    this.flex = 1,
  }) : super(key: key);

  final String text;
  final int flex;
  final Color? buttonColor;
  final double? buttonSize;
  final ValueSetter<String>? onTextInput;
  final VoidCallback? onBackspace;

  Widget makeButton({required String digit, required List<String> characters}) {
    TextStyle digitStyle =
        const TextStyle(fontSize: 26, fontWeight: FontWeight.bold);
    TextStyle alphabetStyle = const TextStyle(fontSize: 22);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          digit,
          style: digitStyle,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: characters.map((alphabet) {
            return Text(
              alphabet,
              style: alphabetStyle,
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
      ),
      onPressed: () =>
          onBackspace == null ? onTextInput!.call(text) : onBackspace!.call(),
      child: onBackspace == null
          ? Text(
              text,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            )
          : const Icon(
              Icons.arrow_back,
            ),
    );
  }
}
