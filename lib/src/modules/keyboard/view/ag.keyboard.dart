import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/extensions/extensions.dart';
import '../provider/ag.keyboard.provider.dart';
import 'components/history.board/slidable.history.board.dart';
import 'components/numpad.layout.dart';

class AgKeyboard extends ConsumerStatefulWidget {
  const AgKeyboard({super.key, required this.initVal});

  final String? initVal;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AgKeyboardState();
}

class _AgKeyboardState extends ConsumerState<AgKeyboard> {

  @override
  void initState() {
    super.initState();
    ref.read(agKeyboardProvider(widget.initVal).notifier).lisentener();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              NumPadLayout(initVal: widget.initVal),
            ],
          ),
        ),
        if (context.isScreenMobile) SlidableHistoryBoard(initVal: widget.initVal),
      ],
    );
  }
}
