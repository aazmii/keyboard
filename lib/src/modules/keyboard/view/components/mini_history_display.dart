import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/extensions/extensions.dart';
import '../../provider/ag.keyboard.provider.dart';

class MiniHistoryDisplay extends ConsumerWidget {
  const MiniHistoryDisplay({super.key, required this.initVal});

  final String? initVal;

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(agKeyboardProvider(initVal));
    final displayText = ref
        .watch(agKeyboardProvider(initVal).notifier.select((v) => v.showText));
    return SizedBox(
      height: context.height * 0.1,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(
                    displayText,
                    style: context.textTheme.headlineSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  LastHistory(initVal: initVal),
                  const Spacer(),
                ],
              ),
            ),
            context.isScreenMobile
                ? HistoryButton(initVal: initVal)
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class LastHistory extends ConsumerWidget {
  const LastHistory({super.key, required this.initVal});

  final String? initVal;

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(agKeyboardProvider(initVal));
    final history = ref
        .watch(agKeyboardProvider(initVal).notifier.select((v) => v.history));
    return history.isNotEmpty
        ? Text(
            history.last,
            style: TextStyle(fontSize: context.txtSize + 2),
          )
        : const SizedBox.shrink();
  }
}

class HistoryButton extends ConsumerWidget {
  const HistoryButton({super.key, required this.initVal});

  final String? initVal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      iconSize: 35.0,
      onPressed: () =>
          ref.watch(agKeyboardProvider(initVal).notifier).toggleHistoryPanel(),
      icon: const Icon(Icons.history),
    );
  }
}
