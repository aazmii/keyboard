import 'package:ag_keyboard/src/extensions/cntx.dart';
import 'package:ag_keyboard/src/modules/keyboard/const/enums.dart';
import 'package:ag_keyboard/src/modules/keyboard/provider/key.press.provider.dart';
import 'package:ag_keyboard/src/modules/keyboard/provider/providers.dart';
import 'package:ag_keyboard/src/modules/keyboard/view/components/constraints.dart';
import 'package:ag_keyboard/src/modules/keyboard/view/components/display.dart';
import 'package:ag_keyboard/src/modules/keyboard/view/components/layout/left.one.third.dart';
import 'package:ag_keyboard/src/modules/keyboard/view/components/history.board/side.history.board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'columns/right.column.dart';

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
    bool isTablet = deviceType == DeviceType.tablet;
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
                      Expanded(
                        flex: context.isPhone ? 7 : 6,
                        //3 COLUMNS-> BACKSPACE, DIVISION AND MULTIPLY
                        child: LeftOneThird(
                          digitColor: digitColor,
                          operatorColor: operatorColor,
                          backColor: backButtonColor,
                          controller: controller,
                        ),
                      ),
                      //1 COLUMN -> SUBSTRACTION, ADDITION AND EQUEL
                      Expanded(
                        flex: context.isPhone ? 2 : 1,
                        child: RightColumn(
                          operatorColor: operatorColor,
                          resColor: resultColor,
                          controller: controller,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isTablet)
            const Expanded(
              flex: 2,
              child: SideHistoryBoard(),
            ),
          if (isDesktop)
            Expanded(
              flex: 5,
              child: SizedBox(
                width: _boardWidth,
                height: keyboardHeight(screenHeight: size.height),
                child: const SideHistoryBoard(),
              ),
            ),
        ],
      ),
    );
  }
}
