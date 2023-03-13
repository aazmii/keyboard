import 'package:ag_keyboard/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../enum/enums.dart';
import '../../helpers/helpers.dart';

class AgButton extends ConsumerWidget {
  const AgButton({
    super.key,
    required this.calcKey,
    this.controller,
    this.onTextInput,
    this.onBackspace,
    this.onCalculate,
    this.color,
    this.iconData,
    this.onLongPressOnBackButton,
  });
  final TextEditingController? controller;
  final IconData? iconData;
  final CalcKey calcKey;
  final Color? color;
  final ValueSetter<String>? onTextInput;
  final VoidCallback? onBackspace;
  final VoidCallback? onCalculate;
  final VoidCallback? onLongPressOnBackButton;

  void _textInputHandler(String text) => onTextInput!.call(text);
  void _backspaceHandler() => onBackspace!.call();

  @override
  Widget build(BuildContext context, ref) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: color,
        child: InkWell(
          splashColor: Theme.of(context).splashColor,
          onTap: () {
            if (calcKey.keyType == Type.number ||
                calcKey.keyType == Type.operator) {
              return _textInputHandler(calcKey.char);
            }
            if (calcKey.keyType == Type.backspace) {
              return _backspaceHandler();
            }
            if (calcKey.keyType == Type.equal) {
              controller != null ? calculateResult(ref, controller!) : null;
            }
          },
          onLongPress: () {
            if (calcKey.keyType != Type.backspace) return;
            if (onLongPressOnBackButton == null) return;
            return onLongPressOnBackButton!();
          },
          child: Center(
            child: ButtonContent(
              calcKey: calcKey,
              iconData: Icons.backspace_outlined,
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
                  calcKey.char,
                  style: TextStyle(fontSize: context.txtSize + 10),
                ),
                calcKey.characters != null
                    ? getphabet(calcKey.characters)
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
        children: calcKey.characters!.map(
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
