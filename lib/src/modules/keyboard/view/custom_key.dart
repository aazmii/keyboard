import 'package:ag_keyboard/src/modules/keyboard/const/enums.dart';
import 'package:ag_keyboard/src/modules/keyboard/provider/calculation.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomKey extends StatelessWidget {
  const CustomKey({
    Key? key,
    required this.calcKey,
    this.onTextInput,
    this.buttonColor,
    this.buttonSize = 60,
    this.onBackspace,
    this.flex,
  }) : super(key: key);
  final CalcKey calcKey;
  final int? flex;
  final Color? buttonColor;
  final double? buttonSize;
  final ValueSetter<String>? onTextInput;
  final VoidCallback? onBackspace;

  Widget _buildButton({
    required CalcKey calcKey,
    required String digit,
    required List<dynamic>? charList,
  }) {
    TextStyle digitStyle =
        const TextStyle(fontSize: 26, fontWeight: FontWeight.bold);
    TextStyle alphabetStyle = const TextStyle(fontSize: 16);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          calcKey.getChar(calcKey),
          // digit,
          style: digitStyle,
        ),
        calcKey.charactes != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: calcKey.charactes!.map((char) {
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
            ? onTextInput!.call(calcKey.getChar(calcKey))
            : onBackspace!.call()),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: buttonColor,
          ),
          child: Center(
            child: onBackspace == null
                ? _buildButton(
                    digit: calcKey.getChar(calcKey),
                    charList: calcKey.charactes,
                    calcKey: calcKey)
                : const Icon(Icons.backspace_rounded, size: 34),
          ),
        ),
      ),
    );
  }
}

class ResultButton extends ConsumerWidget {
  const ResultButton({
    super.key,
    required this.controller,
    this.buttonColor,
    this.flex = 1,
  });
  final Color? buttonColor;
  final TextEditingController controller;
  final int? flex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Flexible(
      flex: flex ?? 1,
      child: GestureDetector(
        onTap: () {
          if (ref.read(shouldRecalculateProvider)) return;
          if (controller.text.isEmpty) return;
          try {
            String res = ref
                .read(resultProvider.notifier)
                .getResult(expression: controller.text);

            controller.text = res;
            controller.selection = TextSelection.fromPosition(
                TextPosition(offset: controller.text.length));
            ref.read(displayTextProvider.notifier).state += ' = $res';
            ref.read(shouldRecalculateProvider.notifier).state = true;
          } catch (e) {
            //
          }
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
