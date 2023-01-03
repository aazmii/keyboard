import 'package:ag_keyboard/src/modules/keyboard/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final historyList = ref.watch(historyProvider);
        return Scrollbar(
          child: ListView.separated(
            reverse: true,
            itemCount: historyList.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(thickness: 2),
            itemBuilder: (BuildContext context, int index) {
              final slplittedList = historyList[index].split('=');
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _expressionText(slplittedList[0]),
                    const SizedBox(height: 8),
                    _resultText(slplittedList[1]),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Text _resultText(String text) {
    return Text(
      '= $text',
      style: const TextStyle(
        fontSize: 22,
        color: Colors.white,
      ),
    );
  }

  Text _expressionText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        color: Colors.white70,
      ),
    );
  }
}
