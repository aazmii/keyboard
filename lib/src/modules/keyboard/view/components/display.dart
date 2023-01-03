import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/providers.dart';
import 'history.button.dart';

class Display extends ConsumerWidget {
  const Display({super.key, this.height = 70});
  final double? height;

  @override
  Widget build(BuildContext context, ref) {
    String displayText = ref.watch(displayTextProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: height,
      width: double.infinity,
      color: Colors.black45,
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 4),
                DisplayTextWidget(displayText: displayText),
                const Expanded(child: ExpressionList())
              ],
            ),
          ),
          const HistoryButton(),
        ],
      ),
    );
  }
}

class DisplayTextWidget extends StatelessWidget {
  const DisplayTextWidget({
    super.key,
    required this.displayText,
  });

  final String displayText;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          displayText,
          style: const TextStyle(fontSize: 32),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class ExpressionList extends ConsumerWidget {
  const ExpressionList({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: ref.watch(historyProvider).length,
      separatorBuilder: (BuildContext context, int index) => const Text(
        ', ',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      itemBuilder: (BuildContext context, int index) => Text(
        ref.watch(historyProvider)[index],
        style: const TextStyle(fontSize: 18, color: Colors.white70),
      ),
    );
  }
}
