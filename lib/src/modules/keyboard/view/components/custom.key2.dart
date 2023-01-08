import 'package:ag_keyboard/src/modules/keyboard/const/stylize.dart';
import 'package:ag_keyboard/src/modules/keyboard/provider/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../const/enums.dart';

class CustomKey2 extends ConsumerWidget {
  const CustomKey2({
    super.key,
    required this.calcKey,
    this.controller,
    this.onTextInput,
    this.onBackspace,
    this.onCalculate,
    this.color,
    this.iconData,
  });
  final TextEditingController? controller;
  final IconData? iconData;
  final CalcKey calcKey;
  final Color? color;
  final ValueSetter<String>? onTextInput;
  final VoidCallback? onBackspace;
  final VoidCallback? onCalculate;

  void _textInputHandler(String text) => onTextInput!.call(text);
  void _backspaceHandler() => onBackspace!.call();

  @override
  Widget build(BuildContext context, ref) {
    return LayoutBuilder(builder: (BuildContext context, constraints) {
      getDeviceType(constraints);

      return Padding(
        padding: const EdgeInsets.all(1.0),
        child: InkWell(
          onTap: () {
            if (calcKey.keyType == Type.number ||
                calcKey.keyType == Type.operator) {
              return _textInputHandler(calcKey.getChar(calcKey));
            }
            if (calcKey.keyType == Type.backspace) {
              return _backspaceHandler();
            }
            if (calcKey.keyType == Type.equal) {
              controller != null ? calculateResult(ref, controller!) : null;
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: color,
            ),
            // width: width,
            child: Center(
              child: _buildButton(calcKey: calcKey),
            ),
          ),
        ),
      );
    });
  }

  _buildButton({required CalcKey calcKey}) {
    return calcKey.keyType != Type.backspace
        ? Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                calcKey.getChar(calcKey),
                style: calcKey.keyType == Type.operator
                    ? operatorStyle
                    : digitStyle,
              ),
              calcKey.charactes != null
                  ? getphabet(calcKey.charactes)
                  : const SizedBox.shrink(),
            ],
          )
        : Icon(
            iconData,
            size: 28,
          );
  }

  Row getphabet(List<dynamic>? chars) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: calcKey.charactes!.map(
        (char) {
          return Text(
            char,
            style: alphabetStyle,
          );
        },
      ).toList(),
    );
  }
}
