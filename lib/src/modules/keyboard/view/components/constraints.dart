double getNumpadHeight({required double screenHeight}) {
  return 0.5 * screenHeight; //40%of screen height
}

double getDisplayHeight({required double screenHeight}) {
  return 0.1 * screenHeight;
}

double keyboardHeight({required double screenHeight}) {
  return 0.5 * screenHeight + 0.1 * screenHeight;
}
