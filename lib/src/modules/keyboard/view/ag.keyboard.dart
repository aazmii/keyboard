import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/extensions/extensions.dart';
import '../provider/ag.keyboard.provider.dart';
import 'components/history.board/slidable.history.board.dart';
import 'components/numpad.layout.dart';

class AgKeyboard extends ConsumerWidget {
  const AgKeyboard({super.key, required this.initVal});

  final String? initVal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(agKeyboardProvider(initVal).notifier).lisentener();
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              NumPadLayout(initVal: initVal),
            ],
          ),
        ),
        if (context.isScreenMobile) SlidableHistoryBoard(initVal: initVal),
      ],
    );
  }
}
