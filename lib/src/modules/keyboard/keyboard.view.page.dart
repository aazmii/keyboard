import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'enum/enums.dart';
import 'provider/ag.keyboard.provider.dart';
import 'view/ag.keyboard.dart';

class KeyBoardViewPage extends ConsumerStatefulWidget {
  const KeyBoardViewPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _KeyBoardViewPageState();
}

class _KeyBoardViewPageState extends ConsumerState<KeyBoardViewPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  VoidCallback? _showPersistantBottomSheetCallBack;

  @override
  void initState() {
    super.initState();
    _showPersistantBottomSheetCallBack = _showBottomSheet;
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(agKeyboardProvider);
    final agKeyPd = ref.watch(agKeyboardProvider.notifier);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text('Keyboard ')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: TextFormField(
              controller: agKeyPd.controller,
              focusNode: agKeyPd.focusNode,
              onTap: _showPersistantBottomSheetCallBack,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.none,
              showCursor: true,
              validator: (v) {
                if (!checkValid(v)) {
                  return 'Invalid!';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () => print('Get Value ${agKeyPd.controller.text}'),
              child: const Text('Reveal data'))
        ],
      ),
    );
  }

  //*Keyboard is uesed through bottom sheet
  void _showBottomSheet() {
    setState(() => _showPersistantBottomSheetCallBack = null);

    _scaffoldKey.currentState!
        .showBottomSheet((_) => const AgKeyboard())
        .closed
        .whenComplete(() {
      if (mounted) {
        setState(() => _showPersistantBottomSheetCallBack = _showBottomSheet);
      }
    });
  }
}
