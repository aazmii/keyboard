import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utils/extensions/extensions.dart';
import '../../../provider/ag.keyboard.provider.dart';
import 'history.list.dart';

class SlidableHistoryBoard extends ConsumerWidget {
  const SlidableHistoryBoard({super.key, required this.initVal});

  final String? initVal;

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(agKeyboardProvider(initVal));
    final isActive = ref.watch(
        agKeyboardProvider(initVal).notifier.select((v) => v.showHistoryPanel));
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 600),
      curve: Curves.fastOutSlowIn,
      right: isActive ? context.width / 4 : context.width,
      child: Container(
        padding: const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 0),
        height: context.height * 0.7,
        width: context.width * 0.75,
        color: context.theme.scaffoldBackgroundColor,
        child: ListView(
          children: [
            CloseButton(initVal: initVal),
            SizedBox(
              height: context.height * 0.45,
              child: HistoryList(initVal: initVal),
            ),
            Center(child: ClearHistoryButton(initVal: initVal)),
          ],
        ),
      ),
    );
  }
}

class CloseButton extends ConsumerWidget {
  const CloseButton({super.key, required this.initVal});

  final String? initVal;

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
          onTap: () => ref
              .watch(agKeyboardProvider(initVal).notifier)
              .toggleHistoryPanel(),
          child: const Icon(Icons.close),
        ),
      ],
    );
  }
}

class ClearHistoryButton extends StatelessWidget {
  const ClearHistoryButton({super.key, required this.initVal});

  final String? initVal;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: InkWell(
            onTap: () =>
                ref.watch(agKeyboardProvider(initVal).notifier).clearHistory(),
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
