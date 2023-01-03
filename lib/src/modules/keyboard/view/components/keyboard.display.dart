import 'package:ag_keyboard/src/modules/keyboard/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KeyboardDisplay extends ConsumerWidget {
  const KeyboardDisplay({
    super.key,
    required this.displayText,
  });

  final String displayText;

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 70,
      width: double.infinity,
      color: Colors.black45,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Align(
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
          ),
          const HistoryButton(),
        ],
      ),
    );
  }
}

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
        bool show = ref.watch(historyViewProvider);
        return IconButton(
          color: show ? Colors.white : Colors.grey,
          iconSize: 42,
          onPressed: () => _toggleHistoryView(ref, !show),
          icon: const Icon(Icons.history),
        );
      },
    );
  }
}
