import 'package:ag_keyboard/src/modules/keyboard/provider/calculation.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomKey extends StatelessWidget {
  const CustomKey({
    Key? key,
    required this.dispayText,
    this.charList,
    this.onTextInput,
    this.buttonColor,
    this.buttonSize = 60,
    this.onBackspace,
    this.flex,
  }) : super(key: key);

  final String dispayText;
  final int? flex;
  final Color? buttonColor;
  final double? buttonSize;
  final ValueSetter<String>? onTextInput;
  final VoidCallback? onBackspace;
  final List<dynamic>? charList;

  Widget _buileButton(
      {required String digit, required List<dynamic>? charList}) {
    TextStyle digitStyle =
        const TextStyle(fontSize: 26, fontWeight: FontWeight.bold);
    TextStyle alphabetStyle = const TextStyle(fontSize: 16);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          digit,
          style: digitStyle,
        ),
        charList != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: charList.map((char) {
                  return Text(
                    char,
                    style: alphabetStyle,
                  );
                }).toList(),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex ?? 1,
      child: GestureDetector(
        onTap: (() => onBackspace == null
            ? onTextInput!.call(dispayText)
            : onBackspace!.call()),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: buttonColor,
          ),
          child: Center(
            child: onBackspace == null
                ? _buileButton(digit: dispayText, charList: charList)
                : const Icon(Icons.backspace_rounded, size: 34),
          ),
        ),
      ),
    );
  }
}

class ResultButton extends ConsumerWidget {
  const ResultButton(
      {super.key, required this.controller, this.buttonColor, this.flex = 1});
  final Color? buttonColor;
  final TextEditingController controller;
  final int? flex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TextEditingController controller = ref.watch(controllerProvier);

    return Flexible(
      flex: flex ?? 1,
      child: GestureDetector(
        onTap: () {
          if (ref.read(shouldRecalculateProvider)) return;
          if (controller.text.isEmpty) return;
          String res = ref
              .read(resultProvider.notifier)
              .getResult(expression: controller.text);

          // controller.text = '${controller.text} = $res';
          controller.text = res;
          ref.read(displayTextProvider.notifier).state += ' = $res';
          ref.read(shouldRecalculateProvider.notifier).state = true;
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: buttonColor,
          ),
          child: const Center(
            child: Text(
              '=',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
