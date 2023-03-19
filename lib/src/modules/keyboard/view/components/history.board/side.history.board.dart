import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utils/extensions/extensions.dart';
import '../../../provider/ag.keyboard.provider.dart';
import 'history.list.dart';

class SideHistoryBoard extends StatelessWidget {
  const SideHistoryBoard({super.key, required this.initVal});

  final String? initVal;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 12),
          Center(
            child: Text(
              'History',
              style: TextStyle(fontSize: context.txtSize + 8),
            ),
          ),
          Expanded(child: HistoryList(initVal: initVal)),
          Consumer(
            builder: (_, ref, __) => Padding(
              padding: const EdgeInsets.only(right: 20.0, bottom: 15),
              child: IconButton(
                color: context.theme.colorScheme.error.withOpacity(0.7),
                onPressed: () => ref
                    .watch(agKeyboardProvider(initVal).notifier)
                    .clearHistory(),
                icon: const Icon(Icons.delete_forever),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
