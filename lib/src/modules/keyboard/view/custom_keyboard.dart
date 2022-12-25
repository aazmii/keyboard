// import 'package:ag_keyboard/src/modules/keyboard/provider/calculation.provider.dart';
// import 'package:ag_keyboard/src/modules/keyboard/view/custom_layout.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class CustomKeyboard extends StatefulWidget {
//   const CustomKeyboard(
//       {super.key,
//       this.backgroundColor,
//       this.digitColor = Colors.blue,
//       this.operatorColor = Colors.cyan,
//       required this.textController,
//       required this.focusNode,
//       this.backButtonColor = Colors.red,
//       this.pointColor = Colors.grey,
//       this.resultColor = Colors.cyan});
//   final TextEditingController textController;

//   final Color? backgroundColor,
//       digitColor,
//       operatorColor,
//       backButtonColor,
//       pointColor,
//       resultColor;
//   final FocusNode focusNode;

//   @override
//   State<CustomKeyboard> createState() => _CustomKeyboardState();
// }

// class _CustomKeyboardState extends State<CustomKeyboard> {
//   bool isKeyboardVisible = false;
//   final int backspaceIndex = 12;
//   void _toggleFocus(BuildContext context) {
//     setState(() => isKeyboardVisible = widget.focusNode.hasFocus);
//   }

//   @override
//   void initState() {
//     super.initState();
//     widget.focusNode.addListener(() {
//       _toggleFocus(context);
//     });
//   }

//   @override
//   void dispose() {
//     widget.focusNode.removeListener(() {
//       _toggleFocus(context);
//     });
//     widget.focusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Visibility(
//       visible: isKeyboardVisible,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           TextField(
//             style: Theme.of(context).textTheme.headlineMedium,
//             keyboardType: TextInputType.none,
//             controller: widget.textController,
//             autofocus: false,
//             decoration: _displayDecoration(),
//             showCursor: true,
//           ),
//           Container(
//             padding: const EdgeInsets.only(top: 10, bottom: 10),
//             height: 350,
//             color: widget.backgroundColor,
//             // child: getGridLayout(),

//             child: Consumer(
//               builder: (context, ref, child) {
//                 return CustomLayout(
//                   onTextInput: (myText) {
//                     _insertText(myText, ref);
//                   },
//                   onBackspace: () {
//                     ref.watch(calculationProvider).shouldRecalculate
//                         ? null
//                         : _backspace();
//                   },
//                   digitColor: widget.digitColor,
//                   operatorColor: widget.operatorColor,
//                   pointColor: widget.pointColor,
//                   backButtonColor: widget.backButtonColor,
//                   resultColor: widget.resultColor,
//                 );
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   void _insertText(String myText, WidgetRef ref) {
//     bool recalculate = ref.read(calculationProvider).shouldRecalculate;
//     if (recalculate) {
//       widget.textController.clear();
//       ref.watch(calculationProvider).shouldRecalculate = false;
//     }
//     final text = widget.textController.text;
//     final textSelection = widget.textController.selection;
//     final newText = text.replaceRange(
//       textSelection.start,
//       textSelection.end,
//       myText,
//     );
//     final myTextLength = myText.length;
//     widget.textController.text = newText;
//     widget.textController.selection = textSelection.copyWith(
//       baseOffset: textSelection.start + myTextLength,
//       extentOffset: textSelection.start + myTextLength,
//     );
//   }

//   void _backspace() {
//     final text = widget.textController.text;
//     final textSelection = widget.textController.selection;
//     final selectionLength = textSelection.end - textSelection.start;

//     // There is a selection.
//     if (selectionLength > 0) {
//       final newText = text.replaceRange(
//         textSelection.start,
//         textSelection.end,
//         '',
//       );
//       widget.textController.text = newText;
//       widget.textController.selection = textSelection.copyWith(
//         baseOffset: textSelection.start,
//         extentOffset: textSelection.start,
//       );
//       return;
//     }

//     // The cursor is at the beginning.
//     if (textSelection.start == 0) {
//       return;
//     }

//     // Delete the previous character
//     final previousCodeUnit = text.codeUnitAt(textSelection.start - 1);
//     final offset = _isUtf16Surrogate(previousCodeUnit) ? 2 : 1;
//     final newStart = textSelection.start - offset;
//     final newEnd = textSelection.start;
//     final newText = text.replaceRange(
//       newStart,
//       newEnd,
//       '',
//     );
//     widget.textController.text = newText;
//     widget.textController.selection = textSelection.copyWith(
//       baseOffset: newStart,
//       extentOffset: newStart,
//     );
//   }

//   bool _isUtf16Surrogate(int value) {
//     return value & 0xF800 == 0xD800;
//   }

//   InputDecoration _displayDecoration() => InputDecoration(
//         fillColor: Colors.grey.withOpacity(0.3),
//         filled: true,
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 10,
//           vertical: 12,
//         ),
//         border: InputBorder.none,
//       );
// }
