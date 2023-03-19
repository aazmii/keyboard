import '../../../provider/ag.keyboard.provider.dart';
import '../../../../../utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'history.list.dart';

class SlidableHistoryBoard extends ConsumerWidget {
  const SlidableHistoryBoard({super.key});

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(agKeyboardProvider);
    final isActive = ref
        .watch(agKeyboardProvider.notifier.select((v) => v.showHistoryPanel));
    final activePosition = context.width / 4;
    final deactivePosition = context.width;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 600),
      curve: Curves.fastOutSlowIn,
      right: isActive ? activePosition : deactivePosition,
      child: Container(
        padding: const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 0),
        height: context.height * 0.7,
        width: context.width * 0.75,
        color: context.theme.scaffoldBackgroundColor,
        child: ListView(
          children: [
            const CloseButton(),
            SizedBox(
              height: context.height * 0.45,
              child: HistoryList(),
            ),
            const Center(child: ClearHistoryButton()),
          ],
        ),
      ),
    );
  }
}

class CloseButton extends ConsumerWidget {
  const CloseButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Spacer(),
        Text(
          'History',
          style: TextStyle(fontSize: context.txtSize + 8),
        ),
        const Spacer(),
        InkWell(
          onTap: () =>
              ref.watch(agKeyboardProvider.notifier).toggleHistoryPanel(),
          child: const Icon(Icons.close),
        ),
      ],
    );
  }
}

class ClearHistoryButton extends StatelessWidget {
  const ClearHistoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: InkWell(
            onTap: () => ref.watch(agKeyboardProvider.notifier).clearHistory(),
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
