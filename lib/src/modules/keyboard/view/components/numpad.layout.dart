import 'package:ag_keyboard/src/modules/keyboard/const/enums.dart';
import 'package:ag_keyboard/src/modules/keyboard/provider/helper.dart';
import 'package:ag_keyboard/src/modules/keyboard/provider/key.press.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    required this.numpadHeight,
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
  final double? numpadHeight;
  final DeviceType deviceType;
  // void _textInputHandler(String text) => onTextInput!.call(text);
  // void _backspaceHandler() => onBackspace!.call();

  @override
  Widget build(BuildContext context, ref) {
    Size size = MediaQuery.of(context).size;
    bool isMobile = deviceType == DeviceType.mobile;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 2,
            right: 2,
            bottom: 4,
          ),
          height: numpadHeight,
          width: isMobile ? size.width : size.width / 1.7,
          color: backgroundColor,
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
    return Container(
      color: Colors.black,
      child: Row(
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
      ),
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
