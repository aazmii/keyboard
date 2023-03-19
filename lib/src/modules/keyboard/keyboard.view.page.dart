import 'provider/ag.keyboard.provider.dart';
import 'package:flutter/material.dart';
import 'view/ag.keyboard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KeyboardViewPage extends StatefulWidget {
  const KeyboardViewPage({super.key});

  @override
  State<KeyboardViewPage> createState() => _KeyboardViewState();
}

class _KeyboardViewState extends State<KeyboardViewPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  VoidCallback? _showPersistantBottomSheetCallBack;

  @override
  void initState() {
    super.initState();
    _showPersistantBottomSheetCallBack = _showBottomSheet;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text('Keyboard ')),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Consumer(builder: (_, ref, __) {
          final agKeyPd = ref.watch(agKeyboardProvider.notifier);
          return Form(
            child: TextFormField(
              controller: agKeyPd.controller,
              focusNode: agKeyPd.focusNode,
              onTap: _showPersistantBottomSheetCallBack,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.none,
              showCursor: true,
            ),
          );
        }),
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
