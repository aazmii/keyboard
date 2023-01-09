// RegExp expPattern = RegExp(r'\d+\.?\d* [\+\-\*\/] \d+\.?\d*');
// RegExp expPattern = RegExp(r'[0-9]+[,.]{0,1}[0-9]*');
RegExp expPattern = RegExp(r'(\d+)([\+\-\*\/])(\d+)$');

// ^(\d+)([\+\-\*\/])(\d+)$
// Test the regular expression
// String string = "2 + 3";
// if (expPattern.hasMatch(string)) {
//   print("Match found: $string");
// } else {
//   print("Match not found");
// }
// inputFormatters: [dfd
                  // FilteringTextInputFormatter.allow(RegExp(
                  //     r'^[-+]?[0-9]*\.?[0-9]+([-+*/]?([0-9]*\.?[0-9]+))*$')),
                  // FilteringTextInputFormatter.allow(RegExp("[0-9\.\+\-\s]")),
                  // FilteringTextInputFormatter.allow(expPattern),
                  // ],