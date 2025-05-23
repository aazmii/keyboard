import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../enum/enums.dart';
import '../function/input.formatters.dart';
import '../provider/ag.keyboard.provider.dart';
import '../view/ag.keyboard.dart';

class TestKeyBoardView extends ConsumerStatefulWidget {
  const TestKeyBoardView({super.key, this.initVal});

  final String? initVal;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TestKeyBoardViewState();
}

class _TestKeyBoardViewState extends ConsumerState<TestKeyBoardView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  VoidCallback? _showPersistantBottomSheetCallBack;

  @override
  void initState() {
    super.initState();
    _showPersistantBottomSheetCallBack = _showBottomSheet;
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(agKeyboardProvider(widget.initVal));
    final agKeyPd = ref.watch(agKeyboardProvider(widget.initVal).notifier);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text('Keyboard ')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: TextFormField(
              showCursor: true,
              focusNode: agKeyPd.focusNode,
              controller: agKeyPd.controller,
              keyboardType: TextInputType.none,
              onTap: _showPersistantBottomSheetCallBack,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              inputFormatters: [createInputFormatter(allowedChars)],
              onFieldSubmitted: (_) => agKeyPd.checkText(context),
              validator: (v) {
                if (!checkValid(v)) return 'Invalid!';
                return null;
              },
            ),
          ),
          // const SizedBox(height: 20),
          // ElevatedButton(
          //   onPressed: () => print('Get Value ${agKeyPd.controller.text}'),
          //   child: const Text('Reveal data'),
          // ),
        ],
      ),
    );
  }

  //*Keyboard is uesed through bottom sheet
  void _showBottomSheet() {
    setState(() => _showPersistantBottomSheetCallBack = null);
    _scaffoldKey.currentState!
        .showBottomSheet((_) => AgKeyboard(initVal: widget.initVal))
        .closed
        .whenComplete(() {
      if (mounted) {
        setState(() => _showPersistantBottomSheetCallBack = _showBottomSheet);
      }
    });
  }
}
