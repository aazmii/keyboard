import 'package:ag_keyboard/src/modules/keyboard/provider/helper.dart';
import 'package:ag_keyboard/src/modules/keyboard/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'const/exp.dart';
import 'view/ag.keyboard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KeyboardView2 extends StatefulWidget {
  const KeyboardView2({super.key});

  @override
  State<KeyboardView2> createState() => _TestPageState();
}

class _TestPageState extends State<KeyboardView2> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  VoidCallback? _showPersistantBottomSheetCallBack;
  final FocusNode _focusNode1 = FocusNode();
  final _controller = TextEditingController();
  @override
  void initState() {
    _showPersistantBottomSheetCallBack = _showBottomSheet;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Consumer(
        builder: (context, ref, child) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Form(
                key: ref.read(formKeyProvider),
                child: TextFormField(
                  onFieldSubmitted: (value) {},
                  onChanged: (value) {
                    AgKeyboard.checkExpression(value);
                    ref.watch(keyPressProvider).insertText(
                          controller: _controller,
                          replace: true,
                          myText: value,
                          ref: ref,
                        );
                    // ref.watch(displayTextProvider.notifier).state = value;
                  },
                  controller: _controller,
                  focusNode: _focusNode1,
                  onTap: _showPersistantBottomSheetCallBack,
                  validator: (value) {
                    return AgKeyboard.checkExpression(value);
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.none,
                  showCursor: true,
                  style: Theme.of(context).textTheme.headlineSmall,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: ''),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet() {
    setState(() {
      _showPersistantBottomSheetCallBack = null;
    });

    _scaffoldKey.currentState!
        .showBottomSheet((context) {
          return AgKeyboard(
            focusNode: _focusNode1,
            controller: _controller,
            backgroundColor: Colors.grey.shade900,
            digitColor: Colors.grey.shade700,
            historyColor: Colors.grey.shade900,
            operatorColor: Colors.grey.shade800,
            pointColor: Colors.grey.shade800,
            resultColor: Colors.grey.shade600,
          );
          // return Container(
          //   color: Colors.amber,
          //   height: 300,
          // );
        })
        .closed
        .whenComplete(() {
          if (mounted) {
            setState(() {
              _showPersistantBottomSheetCallBack = _showBottomSheet;
            });
          }
        });
  }
}
