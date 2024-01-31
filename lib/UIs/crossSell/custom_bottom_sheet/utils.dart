extension DoubleExtension on double {
  bool isBetween({required min, required max}) {
    if (this >= min && this <= max) {
      return true;
    } else {
      return false;
    }
  }
}
