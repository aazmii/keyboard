import 'package:ag_keyboard/src/modules/keyboard/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'exp.container.dart';

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
            itemBuilder: (BuildContext context, int index) => Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              child: ExpressionContainer(
                expression: historyList[index],
              ),
            ),
          ),
        );
      },
    );
  }
}
