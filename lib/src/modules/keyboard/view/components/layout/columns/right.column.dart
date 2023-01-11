import 'package:ag_keyboard/src/modules/keyboard/const/enums.dart';
import 'package:ag_keyboard/src/modules/keyboard/provider/providers.dart';
import 'package:ag_keyboard/src/modules/keyboard/view/components/custom.key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RightColumn extends ConsumerWidget {
  final Color? operatorColor, resColor;
  final TextEditingController controller;
  const RightColumn({
    super.key,
    required this.controller,
    this.operatorColor,
    this.resColor,
  });

  @override
  Widget build(BuildContext context, ref) {
    final press = ref.watch(keyPressProvider);
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Column(
        children: [
          Expanded(
            flex: 8,
            child: CustomKey(
              calcKey: CalcKey.substract,
              color: operatorColor,
              onTextInput: (value) {
                press.insertText(
                    myText: value, ref: ref, controller: controller);
              },
            ),
          ),
          Expanded(
            flex: 15,
            child: CustomKey(
              calcKey: CalcKey.add,
              color: operatorColor,
              onTextInput: (value) {
                press.insertText(
                    myText: value, ref: ref, controller: controller);
              },
            ),
          ),
          Expanded(
            flex: 15,
            child: CustomKey(
              //!controller needed

              calcKey: CalcKey.equalKey,
              controller: controller,
              color: resColor,
            ),
          ),
        ],
      ),
    );
  }
}
