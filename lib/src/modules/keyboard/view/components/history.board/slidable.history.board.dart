import 'package:ag_keyboard/src/extensions/cntx.dart';
import 'package:ag_keyboard/src/modules/keyboard/provider/providers.dart';
import 'package:ag_keyboard/src/modules/keyboard/view/components/constraints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'history.list.dart';
import 'ui.notifier.dart';

class SlidableHistoryBoard extends ConsumerWidget {
  const SlidableHistoryBoard({
    this.historyColor = Colors.lightBlue,
    super.key,
  });
  final Color? historyColor;

  final _duration = const Duration(milliseconds: 600);
  @override
  Widget build(BuildContext context, ref) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final historyBoardHeight = getDisplayHeight(screenHeight: screenHeight) +
        getNumpadHeight(screenHeight: screenHeight);
    bool isActive = ref.watch(historyViewProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final activePosition = screenWidth / 4;
    final deactivePosition = screenWidth;

    return AnimatedPositioned(
      duration: _duration,
      curve: Curves.fastOutSlowIn,
      right: isActive ? activePosition : deactivePosition,
      child: Container(
        padding: const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 0),
        height: historyBoardHeight + screenHeight * 0.1,
        width: MediaQuery.of(context).size.width * 0.75,
        color: historyColor,
        child: ListView(
          children: [
            _closeButton(ref: ref, context: context, name: 'Keyboard'),
            SizedBox(
              height: screenHeight * 0.48,
              child: HistoryList(),
            ),
            const Center(child: ClearHistoryButton()),
          ],
        ),
      ),
    );
  }

  Widget _closeButton(
      {String name = '', required ref, required BuildContext context}) {
    return GestureDetector(
      onTap: () {
        ref.watch(historyViewProvider.notifier).state = false;
      },
      child: Center(
        child: Text(name, style: TextStyle(fontSize: context.txtSize + 8)),
      ),
    );
  }
}

class ClearHistoryButton extends StatelessWidget {
  const ClearHistoryButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: GestureDetector(
            onTap: () {
              ref.watch(historyProvider.notifier).state = [];
              ref.watch(historyViewProvider.notifier).state = false;
              notifyUser(context, 'history cleared');
            },
            child: Text(
              'Clear History',
              style: TextStyle(fontSize: context.txtSize - 2),
            ),
          ),
        ),
      ),
    );
  }
}
