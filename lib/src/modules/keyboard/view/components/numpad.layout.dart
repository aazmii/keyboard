import 'package:ag_keyboard/src/modules/keyboard/const/enums.dart';
import 'package:ag_keyboard/src/modules/keyboard/provider/key.press.provider.dart';
import 'package:ag_keyboard/src/modules/keyboard/provider/providers.dart';
import 'package:ag_keyboard/src/modules/keyboard/view/components/constraints.dart';
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
    required this.backgroundColor,
    required this.keyPress,
    required this.controller,
    required this.digitColor,
    required this.operatorColor,
    required this.pointColor,
    required this.backButtonColor,
    required this.resultColor,
    required this.deviceType,
  });

  final Color? backgroundColor;
  final KeyPressProvider keyPress;
  final TextEditingController controller;
  final Color? digitColor;
  final Color? operatorColor;
  final Color? pointColor;
  final Color? backButtonColor;
  final Color? resultColor;
  final double numPadHeight;
  final double horizontalSpacing = 30;
  final double vSpacing = 8;
  final ValueSetter<String>? onTextInput;
  final VoidCallback? onBackspace;
  final DeviceType deviceType;
  final double _boardWidth = 380;
  // void _textInputHandler(String text) => onTextInput!.call(text);
  // void _backspaceHandler() => onBackspace!.call();

  @override
  Widget build(BuildContext context, ref) {
    Size size = MediaQuery.of(context).size;
    final double numpadHeight = getNumpadHeight(screenHeight: size.height);

    bool isDesktop = deviceType == DeviceType.desktop;
    bool isTablet = deviceType == DeviceType.tablet;
    return Container(
      color: backButtonColor,
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
                    children: const [
                      Expanded(
                        flex: 4,
                        child: LeftOneThird(),
                      ),
                      Expanded(
                        flex: 1,
                        child: RightColumn(),
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
          const Expanded(child: HistoryList()),
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
  const LeftOneThird({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Expanded(
          flex: 12,
          child: GridButtons(),
        ),
        Expanded(
          flex: 4,
          child: BottomRow(),
        ),
      ],
    );
  }
}

class RightColumn extends StatelessWidget {
  const RightColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 1.0),
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: demoButton(14),
          ),
          const SizedBox(height: 1),
          Expanded(
            flex: 6,
            child: demoButton(15),
          ),
          const SizedBox(height: 1),
          Expanded(
            flex: 6,
            child: demoButton(16),
          ),
        ],
      ),
    );
  }
}

class GridButtons extends StatelessWidget {
  const GridButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(01.0),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            // child: demoButton(0),
            child: backSpaceCol(),
          ),
          const SizedBox(width: 1),
          Flexible(
            flex: 1,
            child: divisionColumn(),
          ),
          const SizedBox(width: 1),
          Flexible(
            flex: 1,
            child: multiplyColumn(),
          ),
        ],
      ),
    );
  }

  multiplyColumn() => Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: demoButton(0),
            ),
            const SizedBox(height: 1),
            Flexible(
              flex: 1,
              child: demoButton(13),
            ),
            const SizedBox(height: 1),
            Flexible(
              flex: 1,
              child: demoButton(13),
            ),
          ],
        ),
      );
  divisionColumn() => Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: demoButton(0),
            ),
            const SizedBox(height: 1),
            Flexible(
              flex: 1,
              child: demoButton(13),
            ),
            const SizedBox(height: 1),
            Flexible(
              flex: 1,
              child: demoButton(13),
            ),
          ],
        ),
      );

  backSpaceCol() => Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: demoButton(0),
            ),
            const SizedBox(height: 1),
            Flexible(
              flex: 1,
              child: demoButton(13),
            ),
            const SizedBox(height: 1),
            Flexible(
              flex: 1,
              child: demoButton(13),
            ),
          ],
        ),
      );
}

class BottomRow extends StatelessWidget {
  const BottomRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: demoButton(12),
        ),
        const SizedBox(width: 1),
        Flexible(
          flex: 1,
          child: demoButton(13),
        ),
        const SizedBox(width: 1),
      ],
    );
  }
}

Widget demoButton(int num) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.blue.shade200,
      ),
      // color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
      child: Center(child: Text(num.toString())),
    );
