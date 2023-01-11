import 'package:ag_keyboard/src/modules/keyboard/provider/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../const/enums.dart';
import '../../../../extensions/cntx.dart';

class CustomKey extends ConsumerWidget {
  const CustomKey({
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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.blue,
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
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            constraints: const BoxConstraints(
              minWidth: 50,
              minHeight: 100,
              maxHeight: 100,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: color,
            ),
            child: Center(
              child: ButtonContent(
                calcKey: calcKey,
                iconData: Icons.backspace_outlined,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonContent extends StatelessWidget {
  const ButtonContent({super.key, required this.calcKey, this.iconData});

  final CalcKey calcKey;
  final IconData? iconData;
  @override
  Widget build(BuildContext context) {
    return calcKey.keyType != Type.backspace
        ? SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  calcKey.getChar(calcKey),
                  style: TextStyle(fontSize: context.txtSize + 10),
                ),
                calcKey.charactes != null
                    ? getphabet(calcKey.charactes)
                    : const SizedBox.shrink(),
              ],
            ),
          )
        : Icon(
            iconData,
            size: 28,
          );
  }

  Widget getphabet(List<dynamic>? chars) {
    return Builder(builder: (context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: calcKey.charactes!.map(
          (char) {
            return Text(
              char,
              style: TextStyle(fontSize: context.txtSize - 4),
            );
          },
        ).toList(),
      );
    });
  }
}
