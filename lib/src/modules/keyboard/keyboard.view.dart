import 'package:ag_keyboard/src/modules/keyboard/provider/providers.dart';
import 'package:flutter/material.dart';
import 'view/ag.keyboard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class KeyboardView extends StatefulWidget {
  const KeyboardView({super.key});

  @override
  State<KeyboardView> createState() => _KeyboardViewState();
}

class _KeyboardViewState extends State<KeyboardView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  VoidCallback? _showPersistantBottomSheetCallBack;
  final FocusNode _node = FocusNode();
  final _controller = TextEditingController();
  String previousValue = '';

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
      body: Consumer(
        builder: (context, ref, child) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: getTextfield(ref, context),
            ),
          ],
        ),
      ),
    );
  }

  Form getTextfield(WidgetRef ref, BuildContext context) {
    return Form(
      key: ref.read(formKeyProvider),
      child: TextFormField(
        controller: _controller,
        focusNode: _node,
        onFieldSubmitted: (value) => AgKeyboard.onFieldSubmittedHandler(
          value: value,
          ref: ref,
          controller: _controller,
          focusNode: _node,
        ),
        onChanged: (value) =>
            AgKeyboard.onChangeHandler(value: value, ref: ref),
        onTap: _showPersistantBottomSheetCallBack,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.none,
        showCursor: true,
        style: Theme.of(context).textTheme.headlineSmall,
        decoration:
            const InputDecoration(border: OutlineInputBorder(), hintText: ''),
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
            controller: _controller,
            backgroundColor: Colors.grey.shade900,
            digitColor: Colors.grey.shade700,
            historyColor: Colors.grey.shade900,
            operatorColor: Colors.grey.shade800,
            pointColor: Colors.grey.shade800,
            resultColor: Colors.grey.shade600,
          );
        })
        .closed
        .whenComplete(() {
          if (mounted) {
            _node.unfocus();
            setState(() {
              _showPersistantBottomSheetCallBack = _showBottomSheet;
            });
          }
        });
  }
}

//KEPT AS DIFFERENT APPROACH
// class VisibilityView extends StatelessWidget {
//   VisibilityView({super.key});
//   final FocusNode _focusNode1 = FocusNode();
//   final Color agLight = const Color(0xff37B2F3);
//   final Color agDark = const Color(0xff226DC6);
//   final bool isKeyboardVisible = false;
//   final _controller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Keyboard KeyboardView'),
//       ),
//       body: Stack(
//         alignment: AlignmentDirectional.bottomStart,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ListView(
//               children: [
//                 Consumer(
//                   builder: (context, ref, child) {
//                     return Form(
//                       key: ref.watch(formKeyProvider),
//                       child: TextFormField(
//                         focusNode: _focusNode1,
//                         controller: _controller,
//                         onFieldSubmitted: (value) =>
//                             _submissionHandled(value, ref),
//                         onChanged: (value) => _onChangeHandled(value, ref),
//                         validator: (value) {
//                           return AgKeyboard.agValidator(value);
//                         },
//                         autovalidateMode: AutovalidateMode.onUserInteraction,
//                         keyboardType: TextInputType.none,
//                         showCursor: true,

//                         // readOnly: true,
//                         style: Theme.of(context).textTheme.headlineSmall,
//                         decoration: const InputDecoration(
//                             border: OutlineInputBorder(), hintText: ''),
//                       ),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     FocusScope.of(context).unfocus();
//                   },
//                   child: const Text('Close keyboard'),
//                 ),
//               ],
//             ),
//           ),
//           AgKeyboard(
//             focusNode: _focusNode1,
//             // focusNode: myFocus,
//             controller: _controller,
//             backgroundColor: Colors.grey.shade900,
//             digitColor: Colors.grey.shade700,
//             historyColor: Colors.grey.shade900,
//             operatorColor: Colors.grey.shade800,
//             pointColor: Colors.grey.shade800,
//             resultColor: Colors.grey.shade600,
//           ),
//         ],
//       ),
//     );
//   }

//   _onChangeHandled(String value, WidgetRef ref) {
//     bool recalculate = ref.watch(shouldRecalculateProvider);
//     print(_controller.text.length);
//     print(value.length);
//     if (recalculate) {
//       _controller.clear();
//       ref.watch(shouldRecalculateProvider.notifier).state = false;
//     }
//     AgKeyboard.agValidator(value);
//     ref.watch(displayTextProvider.notifier).state = value;

//     ref.watch(keyPressProvider).insertText(
//           controller: _controller,
//           replace: true,
//           myText: value,
//           ref: ref,
//         );
//   }

//   _submissionHandled(String value, WidgetRef ref) {
//     _controller.text = value;
//     calculateResult(ref, _controller);
//     _focusNode1.requestFocus();
//   }
// }
