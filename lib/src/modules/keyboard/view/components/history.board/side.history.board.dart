import 'package:ag_keyboard/src/extensions/cntx.dart';
import 'package:ag_keyboard/src/modules/keyboard/provider/providers.dart';
import 'package:ag_keyboard/src/modules/keyboard/view/components/constraints.dart';
import 'package:ag_keyboard/src/modules/keyboard/view/components/history.board/history.list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ui.notifier.dart';

class SideHistoryBoard extends StatelessWidget {
  const SideHistoryBoard({super.key});
  final double iconSizeLarge = 40;
  final double iconSizeSmall = 40;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: keyboardHeight(screenHeight: size.height - 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 12),
          Center(child: getTitle(context)),
          Expanded(child: HistoryList()),
          Consumer(builder: (context, ref, child) {
            return Padding(
              padding: const EdgeInsets.only(right: 20.0, bottom: 20),
              child: IconButton(
                color: Colors.grey,
                onPressed: () {
                  ref.watch(historyProvider.notifier).state = [];
                  ref.watch(historyViewProvider.notifier).state = false;
                  notifyUser(context, 'history cleared');
                },
                icon: Icon(
                  Icons.delete,
                  size: context.isPhone ? iconSizeSmall : iconSizeLarge,
                ),
              ),
            );
          })
        ],
      ),
    );
  }

  Widget getTitle(context) {
    return Text(
      'History',
      style: Theme.of(context)
          .textTheme
          .headlineSmall!
          .copyWith(color: Colors.grey),
    );
  }
}
