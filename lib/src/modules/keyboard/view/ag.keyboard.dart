import '../../../utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/history.board/slidable.history.board.dart';
import 'components/numpad.layout.dart';

class AgKeyboard extends ConsumerWidget {
  const AgKeyboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  NumPadLayout(),
                ],
              ),
            ),
            if (context.isScreenMobile) const SlidableHistoryBoard(),
          ],
        );
      },
    );
  }
}
