import 'package:ag_keyboard/src/modules/keyboard/provider/providers.dart';
import 'package:ag_keyboard/src/modules/keyboard/view/components/constraints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'history.list.dart';
import 'ui.notifier.dart';

class HistoryBoard extends ConsumerWidget {
  const HistoryBoard({
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
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Container(
          padding:
              const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 0),
          height: historyBoardHeight,
          color: historyColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _closeButton(ref: ref, context: context, name: 'Keyboard'),
              // ClearHistoryButton(),
              const Expanded(
                child: HistoryList(),
              ),
              const ClearHistoryButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _closeButton(
      {String name = '', required ref, required BuildContext context}) {
    return TextButton(
      onPressed: () {
        ref.watch(historyViewProvider.notifier).state = false;
      },
      child: Text(
        name,
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Colors.white,
            ),
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
      builder: (context, ref, child) => TextButton(
        onPressed: () {
          ref.watch(historyProvider.notifier).state = [];
          ref.watch(historyViewProvider.notifier).state = false;
          notifyUser(context, 'history cleared');
        },
        child: Text(
          'Clear History',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
