import 'package:ag_keyboard/src/modules/keyboard/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryButton extends StatelessWidget {
  const HistoryButton({
    super.key,
  });
  _toggleHistoryView(WidgetRef ref, vlaue) {
    ref.watch(historyViewProvider.notifier).state = vlaue;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        bool isOpen = ref.watch(historyViewProvider);
        return IconButton(
          color: isOpen ? Colors.grey : Colors.white,
          iconSize: 42,
          onPressed: ref.watch(historyViewProvider)
              ? null
              : () => _toggleHistoryView(ref, !isOpen),
          icon: const Icon(Icons.history),
        );
      },
    );
  }
}
