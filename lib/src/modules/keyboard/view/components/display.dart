import 'package:ag_keyboard/src/modules/keyboard/const/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/providers.dart';
import '../../../../extensions/cntx.dart';

class Display extends ConsumerWidget {
  const Display({super.key, required this.deviceType});
  final double height = 70;
  final DeviceType deviceType;

  @override
  Widget build(BuildContext context, ref) {
    String displayText = ref.watch(displayTextProvider);
    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        displayText,
                        style: Theme.of(context).textTheme.headlineSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Expanded(child: ExpressionList())
                ],
              ),
            ),
            deviceType == DeviceType.mobile
                ? HistoryButton()
                : const SizedBox.shrink(),
          ],
        ),
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
      separatorBuilder: (BuildContext context, int index) => Text(
        ', ',
        style: TextStyle(color: Colors.white, fontSize: context.txtSize + 2),
      ),
      itemBuilder: (BuildContext context, int index) => Text(
        ref.watch(historyProvider)[index],
        style: TextStyle(fontSize: context.txtSize + 2, color: Colors.white70),
      ),
    );
  }
}

class HistoryButton extends StatelessWidget {
  final Color enabledColor = Colors.grey;
  final Color disabledColor = Colors.grey.shade300;
  HistoryButton({
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
          color: isOpen ? enabledColor : disabledColor,
          iconSize: 42,
          onPressed: ref.watch(historyViewProvider)
              ? null
              : () => _toggleHistoryView(ref, !isOpen),
          icon: const Icon(
            Icons.history,
            size: 35,
          ),
        );
      },
    );
  }
}
