class HelperFunctions {
  static String cOrFConverter({double temp, bool value}) {
    double result = 0.0;
    final suffix = value == true ? 'F' : '°C';
    if (value == false) {
      result = temp;
    } else {
      // This converts to F
      result = (temp * 9 / 5) + 32;
    }
    return result.toStringAsPrecision(2) + suffix;
  }
}
