import 'package:ag_keyboard/src/modules/keyboard/provider/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../const/enums.dart';

class CustomKey extends ConsumerWidget {
  const CustomKey({
    super.key,
    required this.calcKey,
    this.controller,
    this.onTextInput,
    this.onBackspace,
    this.onCalculate,
    this.color,
    this.width = 90,
    this.height = 60,
    this.flex,
    this.iconData,
  });
  final TextEditingController? controller;

  final IconData? iconData;
  final CalcKey calcKey;
  final int? flex;
  final Color? color;
  final double? width, height;
  final ValueSetter<String>? onTextInput;
  final VoidCallback? onBackspace;
  final VoidCallback? onCalculate;
  final TextStyle _digitStyle =
      const TextStyle(fontSize: 26, fontWeight: FontWeight.bold);
  final TextStyle _alphabetStyle = const TextStyle(fontSize: 16);
  final TextStyle _operatorStyle =
      const TextStyle(fontSize: 36, fontWeight: FontWeight.bold);

  void _textInputHandler(String text) => onTextInput!.call(text);
  void _backspaceHandler() => onBackspace!.call();

  @override
  Widget build(BuildContext context, ref) {
    return Flexible(
      flex: flex ?? 1,
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
            borderRadius: BorderRadius.circular(10),
            color: color,
          ),
          // width: width,
          child: Center(
            child: _buildButton(calcKey: calcKey),
          ),
        ),
      ),
    );
  }

  _buildButton({required CalcKey calcKey}) {
    return calcKey.keyType != Type.backspace
        ? Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                calcKey.getChar(calcKey),
                style: calcKey.keyType == Type.operator
                    ? _operatorStyle
                    : _digitStyle,
              ),
              calcKey.charactes != null
                  ? showAlphabets(calcKey.charactes)
                  : const SizedBox.shrink(),
            ],
          )
        : Icon(
            iconData,
            size: 36,
          );
  }

  Row showAlphabets(List<dynamic>? chars) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: calcKey.charactes!.map(
        (char) {
          return Text(
            char,
            style: _alphabetStyle,
          );
        },
      ).toList(),
    );
  }
}
