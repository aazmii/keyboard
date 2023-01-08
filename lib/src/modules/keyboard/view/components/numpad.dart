// import 'package:ag_keyboard/src/modules/keyboard/const/enums.dart';
// import 'package:ag_keyboard/src/modules/keyboard/provider/key.press.provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'custom.key.dart';

// class NumPad extends ConsumerWidget {
//   const NumPad({
//     super.key,
//     this.onTextInput,
//     this.onBackspace,
//     this.numPadHeight = 350,
//     required this.backgroundColor,
//     required this.keyPress,
//     required this.controller,
//     required this.digitColor,
//     required this.operatorColor,
//     required this.pointColor,
//     required this.backButtonColor,
//     required this.resultColor,
//   });

//   final Color? backgroundColor;
//   final KeyPressProvider keyPress;
//   final TextEditingController controller;
//   final Color? digitColor;
//   final Color? operatorColor;
//   final Color? pointColor;
//   final Color? backButtonColor;
//   final Color? resultColor;
//   final double numPadHeight;
//   final double horizontalSpacing = 30;
//   final double vSpacing = 8;
//   final ValueSetter<String>? onTextInput;
//   final VoidCallback? onBackspace;
//   // void _textInputHandler(String text) => onTextInput!.call(text);
//   // void _backspaceHandler() => onBackspace!.call();

//   @override
//   Widget build(BuildContext context, ref) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
//       height: numPadHeight,
//       width: MediaQuery.of(context).size.width,
//       color: backgroundColor,
//       alignment: Alignment.center,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           IntrinsicWidth(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 SizedBox(
//                   height: numPadHeight - 95,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       backSpaceColumn(vSpacing: vSpacing),
//                       const SizedBox(width: 26),
//                       divisionColumn(vSpacing: vSpacing),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 CustomKey(
//                   calcKey: CalcKey.zero,
//                   color: digitColor,
//                   onTextInput: onTextInput,
//                 ),
//               ],
//             ),
//           ),
//           multiplyColumn(vSpacing: vSpacing),
//           customColumn(spacing: vSpacing),
//         ],
//       ),
//     );
//   }

//   Widget backSpaceColumn({double? vSpacing, buttonWidth = 70.0}) {
//     double defaultSpacing = 5;
//     return SizedBox(
//       width: buttonWidth,
//       child: Column(
//         children: [
//           CustomKey(
//             calcKey: CalcKey.backSpace,
//             color: backButtonColor,
//             iconData: Icons.arrow_back_sharp,
//             onBackspace: onBackspace,
//           ),
//           SizedBox(height: vSpacing ?? defaultSpacing),
//           CustomKey(
//             calcKey: CalcKey.one,
//             color: digitColor,
//             onTextInput: onTextInput,
//           ),
//           SizedBox(height: vSpacing ?? defaultSpacing),
//           CustomKey(
//             calcKey: CalcKey.four,
//             color: digitColor,
//             onTextInput: onTextInput,
//           ),
//           SizedBox(height: vSpacing ?? defaultSpacing),
//           CustomKey(
//               calcKey: CalcKey.seven,
//               color: digitColor,
//               onTextInput: onTextInput),
//         ],
//       ),
//     );
//   }

//   Widget divisionColumn({double? vSpacing, buttonWidth = 70.0}) {
//     double defaultSpacing = 5;

//     return SizedBox(
//       width: buttonWidth,
//       child: Column(
//         children: [
//           CustomKey(
//             calcKey: CalcKey.division,
//             color: operatorColor,
//             onTextInput: onTextInput,
//           ),
//           SizedBox(height: vSpacing ?? defaultSpacing),
//           CustomKey(
//             calcKey: CalcKey.two,
//             color: digitColor,
//             onTextInput: onTextInput,
//           ),
//           SizedBox(height: vSpacing ?? defaultSpacing),
//           CustomKey(
//             calcKey: CalcKey.five,
//             color: digitColor,
//             onTextInput: onTextInput,
//           ),
//           SizedBox(height: vSpacing ?? defaultSpacing),
//           CustomKey(
//             calcKey: CalcKey.eight,
//             onTextInput: onTextInput,
//             color: digitColor,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget multiplyColumn({double? vSpacing, buttonWidth = 70.0}) {
//     double defaultSpacing = 5;

//     return SizedBox(
//       width: buttonWidth,
//       child: Column(
//         children: [
//           CustomKey(
//             calcKey: CalcKey.multiply,
//             color: operatorColor,
//             onTextInput: onTextInput,
//           ),
//           SizedBox(height: vSpacing ?? defaultSpacing),
//           CustomKey(
//             calcKey: CalcKey.three,
//             color: digitColor,
//             onTextInput: onTextInput,
//           ),
//           SizedBox(height: vSpacing ?? defaultSpacing),
//           CustomKey(
//             calcKey: CalcKey.six,
//             color: digitColor,
//             onTextInput: onTextInput,
//           ),
//           SizedBox(height: vSpacing ?? defaultSpacing),
//           CustomKey(
//             calcKey: CalcKey.nine,
//             onTextInput: onTextInput,
//             color: digitColor,
//           ),
//           SizedBox(height: vSpacing ?? defaultSpacing),
//           CustomKey(
//             calcKey: CalcKey.point,
//             onTextInput: onTextInput,
//             color: pointColor,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget customColumn({double? spacing, buttonWidth = 70.0}) {
//     double defaultSpacing = 5;

//     return SizedBox(
//       width: buttonWidth,
//       child: Column(
//         children: [
//           CustomKey(
//             calcKey: CalcKey.substract,
//             color: operatorColor,
//             onTextInput: onTextInput,
//             flex: 1,
//           ),
//           SizedBox(height: spacing ?? defaultSpacing),
//           CustomKey(
//             calcKey: CalcKey.add,
//             color: operatorColor,
//             onTextInput: onTextInput,
//             flex: 2,
//           ),
//           SizedBox(height: spacing ?? defaultSpacing),
//           CustomKey(
//             calcKey: CalcKey.equalKey,
//             color: resultColor,
//             controller: controller,
//             flex: 2,
//           ),
//         ],
//       ),
//     );
//   }
// }
