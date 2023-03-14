import 'dart:math';

import 'package:ag_keyboard/src/modules/keyboard/enum/enums.dart';
import 'package:ag_keyboard/src/modules/keyboard/provider/key.press.provider.dart';
import 'package:ag_keyboard/src/modules/keyboard/provider/providers.dart';
import 'package:ag_keyboard/src/modules/keyboard/view/components/constraints.dart';
import 'package:ag_keyboard/src/modules/keyboard/view/components/display.dart';
import 'package:ag_keyboard/src/modules/keyboard/view/components/history.board/side.history.board.dart';
import 'package:ag_keyboard/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NumPadLayout extends ConsumerWidget {
  const NumPadLayout({
    super.key,
    this.onTextInput,
    this.onBackspace,
    this.backgroundColor,
    required this.keyPress,
    required this.controller,
    this.digitColor,
    this.operatorColor,
    this.pointColor,
    this.backButtonColor,
    this.resultColor,
    required this.deviceType,
  });

  final Color? backgroundColor;
  final KeyPressProvider keyPress;
  final TextEditingController controller;
  final double horizontalSpacing = 30;
  final double vSpacing = 8;
  final ValueSetter<String>? onTextInput;
  final VoidCallback? onBackspace;
  final DeviceType deviceType;
  final double _boardWidth = 380;
  final Color? digitColor,
      resultColor,
      backButtonColor,
      pointColor,
      operatorColor;

  @override
  Widget build(BuildContext context, ref) {
    Size size = MediaQuery.of(context).size;
    final double numpadHeight = getNumpadHeight(screenHeight: size.height);
    bool isHitoryPanelOpen = ref.watch(historyViewProvider);

    bool isDesktop = deviceType == DeviceType.desktop;
    // bool isTablet = deviceType == DeviceType.tablet;
    return Container(
      color: backgroundColor,
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (isHitoryPanelOpen) {
                      ref.read(historyViewProvider.notifier).state =
                          !isHitoryPanelOpen;
                    }
                  },
                  //display doesent behave well without wrapping
                  child: ColoredBox(
                    color: backgroundColor!,
                    child: Display(deviceType: deviceType),
                  ),
                ),
                SizedBox(
                  height: numpadHeight,
                  width: size.width,
                  child: Row(
                    children: [
                      ...List.generate(
                        (CalcKey.values.length / 5).ceil(),
                        (outterIdx) => Expanded(
                          child: Column(
                            children: [
                              ...List.generate(
                                min(CalcKey.values.length - (outterIdx * 5), 5),
                                (innerIdx) => KeyboardTile(
                                  calcKey: CalcKey
                                      .values[(outterIdx * 5) + innerIdx],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // child: Row(
                  //   children: [
                  //     Expanded(
                  //       flex: context.isPhone ? 7 : 6,
                  //       //3 COLUMNS-> BACKSPACE, DIVISION AND MULTIPLY
                  //       child: LeftOneThird(
                  //         digitColor: digitColor,
                  //         operatorColor: operatorColor,
                  //         backColor: backButtonColor,
                  //         controller: controller,
                  //       ),
                  //     ),
                  //     //1 COLUMN -> SUBSTRACTION, ADDITION AND EQUEL
                  //     Expanded(
                  //       flex: context.isPhone ? 2 : 1,
                  //       child: RightColumn(
                  //         operatorColor: operatorColor,
                  //         resColor: resultColor,
                  //         controller: controller,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ),
              ],
            ),
          ),
          if (isDesktop)
            const Expanded(
              flex: 2,
              child: SideHistoryBoard(),
            ),
        ],
      ),
    );
  }
}

class KeyboardTile extends StatelessWidget {
  const KeyboardTile({super.key, required this.calcKey});

  final CalcKey calcKey;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: calcKey == CalcKey.equalKey ? 2 : 1,
      child: Container(
        margin: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: context.theme.cardColor,
          border: Border.all(
            color: context.theme.dividerColor,
            width: 1,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                calcKey.char,
                style: context.text.titleLarge,
              ),
              if (calcKey.characters != null)
                Text(
                  calcKey.characters!.join(''),
                  style: context.text.bodySmall,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
