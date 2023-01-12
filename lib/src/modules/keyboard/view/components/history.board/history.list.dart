import 'package:ag_keyboard/src/extensions/cntx.dart';
import 'package:ag_keyboard/src/modules/keyboard/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryList extends StatelessWidget {
  HistoryList({super.key});
  final ScrollController _controller = ScrollController(initialScrollOffset: 0);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final historyList = ref.watch(historyProvider);
        return Scrollbar(
          controller: _controller,
          child: ListView.separated(
            controller: _controller,
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
                    _expressionText(context, slplittedList[0]),
                    const SizedBox(height: 8),
                    _resultText(context, slplittedList[1]),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Text _resultText(BuildContext context, String text) {
    ;
    print(context.txtSize);
    return Text(
      '= $text',
      style: TextStyle(
        fontSize: context.txtSize + 8,
        color: Colors.white,
      ),
    );
  }

  Text _expressionText(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: context.txtSize,
        color: Colors.white70,
      ),
    );
  }
}
