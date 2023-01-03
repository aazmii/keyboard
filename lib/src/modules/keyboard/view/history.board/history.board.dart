import 'package:ag_keyboard/src/modules/keyboard/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'components/history.list.dart';

class HistoryBoard extends ConsumerWidget {
  const HistoryBoard({
    super.key,
    required this.numPadHeight,
    required this.displayHeight,
  });

  final double? numPadHeight;
  final double? displayHeight;

  @override
  Widget build(BuildContext context, ref) {
    bool isActive = ref.watch(historyViewProvider);
    return AnimatedOpacity(
      opacity: isActive ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      child: Visibility(
        visible: isActive,
        child: Container(
          padding:
              const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 0),
          height: numPadHeight! + displayHeight!,
          width: MediaQuery.of(context).size.width * 0.75,
          color: Colors.lightBlue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _closeButton(ref: ref, context: context, name: 'Keyboard'),
              const Expanded(
                child: HistoryList(),
              ),
              const HistoryClearButton(),
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

class HistoryClearButton extends StatelessWidget {
  const HistoryClearButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => TextButton(
        onPressed: () {
          ref.watch(historyProvider.notifier).state.clear();
          ref.watch(historyViewProvider.notifier).state = false;
          // History.histories.clear();
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
