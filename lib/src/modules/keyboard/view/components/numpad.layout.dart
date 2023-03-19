import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/extensions/extensions.dart';
import '../../enum/enums.dart';
import '../../provider/ag.keyboard.provider.dart';
import 'history.board/side.history.board.dart';
import 'mini_history_display.dart';

class NumPadLayout extends ConsumerWidget {
  const NumPadLayout({super.key, required this.initVal});

  final String? initVal;

  @override
  Widget build(BuildContext context, ref) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Column(
            children: [
              MiniHistoryDisplay(initVal: initVal),
              SizedBox(
                height: context.height * 0.5,
                width: context.width,
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
                                initVal: initVal,
                                calcKey:
                                    CalcKey.values[(outterIdx * 5) + innerIdx],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (context.isScreenDesktop)
          Expanded(
            flex: 2,
            child: SideHistoryBoard(initVal: initVal),
          ),
      ],
    );
  }
}

class KeyboardTile extends ConsumerWidget {
  const KeyboardTile({super.key, required this.calcKey, required this.initVal});

  final String? initVal;
  final CalcKey calcKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      flex: calcKey == CalcKey.equalKey ? 2 : 1,
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        splashColor: calcKey == CalcKey.backSpace
            ? context.theme.colorScheme.error
            : context.theme.cardColor,
        onTap: () =>
            ref.watch(agKeyboardProvider(initVal).notifier).pressKey(calcKey),
        onLongPress: calcKey != CalcKey.backSpace
            ? null
            : () => ref
                .watch(agKeyboardProvider(initVal).notifier)
                .pressKey(calcKey, true),
        child: Container(
          margin: const EdgeInsets.all(0.5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: calcKey == CalcKey.backSpace
                ? context.theme.colorScheme.error.withOpacity(0.7)
                : context.theme.cardColor.withOpacity(0.7),
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
      ),
    );
  }
}
