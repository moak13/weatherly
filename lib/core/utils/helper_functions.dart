class HelperFunctions {
  /// converts C to F or fallback to C
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

  /// convert to dateTime object
  static DateTime convertStringDate(String gottenDateString) {
    final dateTime = DateTime.parse(gottenDateString).toLocal();
    return dateTime;
  }
}
