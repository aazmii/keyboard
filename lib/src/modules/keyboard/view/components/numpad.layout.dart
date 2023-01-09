import 'package:ag_keyboard/src/modules/keyboard/const/enums.dart';
import 'package:ag_keyboard/src/modules/keyboard/provider/key.press.provider.dart';
import 'package:ag_keyboard/src/modules/keyboard/provider/providers.dart';
import 'package:ag_keyboard/src/modules/keyboard/view/components/constraints.dart';
import 'package:ag_keyboard/src/modules/keyboard/view/components/custom.key2.dart';
import 'package:ag_keyboard/src/modules/keyboard/view/components/display.dart';
import 'package:ag_keyboard/src/modules/keyboard/view/history.board/history.list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../history.board/ui.notifier.dart';

class NumPadLayout extends ConsumerWidget {
  const NumPadLayout({
    super.key,
    this.onTextInput,
    this.onBackspace,
    this.numPadHeight = 350,
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
  final double numPadHeight;
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
  // void _textInputHandler(String text) => onTextInput!.call(text);
  // void _backspaceHandler() => onBackspace!.call();

  @override
  Widget build(BuildContext context, ref) {
    Size size = MediaQuery.of(context).size;
    final double numpadHeight = getNumpadHeight(screenHeight: size.height);

    bool isDesktop = deviceType == DeviceType.desktop;
    bool isTablet = deviceType == DeviceType.tablet;
    return Container(
      color: backgroundColor,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Display(deviceType: deviceType),
                SizedBox(
                  height: numpadHeight,
                  width: size.width,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: LeftOneThird(
                          digitColor: digitColor,
                          operatorColor: operatorColor,
                          backColor: backButtonColor,
                          controller: controller,
                        ),
                      ),
                      Expanded(
                        flex: 1,
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
            Expanded(
              flex: 2,
              child: showHistoryBoard(size, context),
            ),
          if (isDesktop)
            SizedBox(
              width: _boardWidth,
              height: keyboardHeight(screenHeight: size.height),
              child: showHistoryBoard(size, context),
            ),
        ],
      ),
    );
  }

  SizedBox showHistoryBoard(Size size, BuildContext context) {
    return SizedBox(
      height: keyboardHeight(screenHeight: size.height),
      child: Column(
        children: [
          const SizedBox(height: 12),
          getTitle(context),
          Expanded(child: HistoryList()),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Consumer(builder: (context, ref, child) {
                return IconButton(
                  color: Colors.grey,
                  onPressed: () {
                    ref.watch(historyProvider.notifier).state = [];
                    ref.watch(historyViewProvider.notifier).state = false;
                    notifyUser(context, 'history cleared');
                  },
                  icon: const Icon(Icons.delete),
                );
              }),
            ],
          )
        ],
      ),
    );
  }

  Widget getTitle(context) {
    return Text(
      'History',
      style: Theme.of(context)
          .textTheme
          .headlineSmall!
          .copyWith(color: Colors.grey),
    );
  }
}

class LeftOneThird extends StatelessWidget {
  final Color? digitColor, operatorColor, backColor;
  final TextEditingController controller;
  const LeftOneThird({
    this.digitColor,
    this.operatorColor,
    this.backColor,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: GridButtons(
            digitColor: digitColor,
            operatorColor: operatorColor,
            controller: controller,
            backColor: backColor,
          ),
        ),
        Expanded(
          flex: 1,
          child: BottomRow(
            digitColor: digitColor,
            operatorColor: operatorColor,
            controller: controller,
          ),
        ),
      ],
    );
  }
}

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
            flex: 3,
            child: CustomKey2(
              calcKey: CalcKey.substract,
              color: operatorColor,
              onTextInput: (value) {
                press.insertText(
                    myText: value, ref: ref, controller: controller);
              },
            ),
          ),
          Expanded(
            flex: 6,
            child: CustomKey2(
              calcKey: CalcKey.add,
              color: operatorColor,
              onTextInput: (value) {
                press.insertText(
                    myText: value, ref: ref, controller: controller);
              },
            ),
          ),
          Expanded(
            flex: 6,
            child: CustomKey2(
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

class GridButtons extends ConsumerWidget {
  final Color? digitColor, operatorColor, backColor;
  final TextEditingController controller;
  const GridButtons({
    this.digitColor,
    required this.controller,
    this.backColor = Colors.red,
    this.operatorColor,
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          // child: demoButton(0),
          child: backSpaceCol(ref),
        ),
        Flexible(
          flex: 1,
          child: divisionColumn(ref),
        ),
        Flexible(
          flex: 1,
          child: multiplyColumn(ref),
        ),
      ],
    );
  }

  multiplyColumn(WidgetRef ref) {
    final press = ref.watch(keyPressProvider);
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: CustomKey2(
            calcKey: CalcKey.multiply,
            color: operatorColor,
            onTextInput: (value) {
              press.insertText(myText: value, ref: ref, controller: controller);
            },
          ),
        ),
        Flexible(
          flex: 1,
          child: CustomKey2(
            calcKey: CalcKey.three,
            color: digitColor,
            onTextInput: (value) {
              press.insertText(myText: value, ref: ref, controller: controller);
            },
          ),
        ),
        Flexible(
          flex: 1,
          child: CustomKey2(
            calcKey: CalcKey.six,
            color: digitColor,
            onTextInput: (value) {
              press.insertText(myText: value, ref: ref, controller: controller);
            },
          ),
        ),
        Flexible(
          flex: 1,
          child: CustomKey2(
            calcKey: CalcKey.nine,
            color: digitColor,
            onTextInput: (value) {
              press.insertText(myText: value, ref: ref, controller: controller);
            },
          ),
        ),
      ],
    );
  }

  divisionColumn(WidgetRef ref) {
    final press = ref.watch(keyPressProvider);
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: CustomKey2(
            calcKey: CalcKey.division,
            color: operatorColor,
            // controller: controller,
            onTextInput: (value) {
              press.insertText(myText: value, ref: ref, controller: controller);
            },
          ),
        ),
        Flexible(
          flex: 1,
          child: CustomKey2(
            calcKey: CalcKey.two,
            color: digitColor,
            // controller: controller,
            onTextInput: (value) {
              press.insertText(myText: value, ref: ref, controller: controller);
            },
          ),
        ),
        Flexible(
          flex: 1,
          child: CustomKey2(
            calcKey: CalcKey.five,
            color: digitColor,
            // controller: controller,
            onTextInput: (value) {
              press.insertText(myText: value, ref: ref, controller: controller);
            },
          ),
        ),
        Flexible(
          flex: 1,
          child: CustomKey2(
            calcKey: CalcKey.eight,
            color: digitColor,
            // controller: controller,
            onTextInput: (value) {
              press.insertText(myText: value, ref: ref, controller: controller);
            },
          ),
        ),
      ],
    );
  }

  backSpaceCol(WidgetRef ref) {
    final press = ref.watch(keyPressProvider);

    return Column(
      children: [
        Flexible(
          flex: 1,
          child: CustomKey2(
              calcKey: CalcKey.backSpace,
              iconData: Icons.backspace_outlined,
              color: backColor ?? Colors.red,
              onBackspace: () =>
                  press.backspace(textController: controller, ref: ref)),
        ),
        Flexible(
          flex: 1,
          child: CustomKey2(
            calcKey: CalcKey.one,
            color: digitColor,
            onTextInput: (value) {
              press.insertText(myText: value, ref: ref, controller: controller);
            },
          ),
        ),
        Flexible(
          flex: 1,
          child: CustomKey2(
            calcKey: CalcKey.four,
            color: digitColor,
            onTextInput: (value) => press.insertText(
                myText: value, ref: ref, controller: controller),
          ),
        ),
        Flexible(
          flex: 1,
          child: CustomKey2(
            calcKey: CalcKey.seven,
            color: digitColor,
            onTextInput: (value) => press.insertText(
                myText: value, ref: ref, controller: controller),
          ),
        ),
      ],
    );
  }
}

class BottomRow extends ConsumerWidget {
  final Color? digitColor, operatorColor;
  final TextEditingController controller;
  const BottomRow({
    super.key,
    this.digitColor,
    required this.controller,
    this.operatorColor,
  });

  @override
  Widget build(BuildContext context, ref) {
    final press = ref.watch(keyPressProvider);
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: CustomKey2(
            calcKey: CalcKey.zero,
            color: digitColor,
            onTextInput: (value) {
              press.insertText(myText: value, ref: ref, controller: controller);
            },
          ),
        ),
        Flexible(
          flex: 1,
          child: CustomKey2(
            calcKey: CalcKey.point,
            color: digitColor,
            onTextInput: (value) {
              press.insertText(myText: value, ref: ref, controller: controller);
            },
          ),
        ),
      ],
    );
  }
}
