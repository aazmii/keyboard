import 'dart:math';

import '../../enum/enums.dart';
import '../../provider/ag.keyboard.provider.dart';
import 'history.board/side.history.board.dart';
import '../../../../utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'mini_history_display.dart';

class NumPadLayout extends ConsumerWidget {
  const NumPadLayout({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Column(
            children: [
              const MiniHistoryDisplay(),
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
          const Expanded(
            flex: 2,
            child: SideHistoryBoard(),
          ),
      ],
    );
  }
}

class KeyboardTile extends ConsumerWidget {
  const KeyboardTile({super.key, required this.calcKey});

  final CalcKey calcKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      flex: calcKey == CalcKey.equalKey ? 2 : 1,
      child: InkWell(
        onTap: () => ref.watch(agKeyboardProvider.notifier).pressKey(calcKey),
        child: Container(
          margin: const EdgeInsets.all(2.0),
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
