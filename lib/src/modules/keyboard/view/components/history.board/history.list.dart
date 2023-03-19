import '../../../provider/ag.keyboard.provider.dart';
import '../../../../../utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryList extends ConsumerWidget {
  HistoryList({super.key, required this.initVal});

  final String? initVal;

  final ScrollController _controller = ScrollController(initialScrollOffset: 0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyList =
        ref.watch(agKeyboardProvider(initVal).notifier.select((v) => v.history));
    return Scrollbar(
      controller: _controller,
      child: ListView.separated(
        controller: _controller,
        reverse: true,
        itemCount: historyList.length,
        separatorBuilder: (_, index) => const Divider(thickness: 2),
        itemBuilder: (context, index) {
          final slplittedList = historyList[index].split('=');
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  slplittedList[0],
                  style: context.textTheme.titleLarge,
                ),
                const SizedBox(height: 5),
                Text(
                  '= ${slplittedList[1]}',
                  style: context.textTheme.titleMedium,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
