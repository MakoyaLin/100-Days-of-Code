/// add dart doc
class Converter {
  /// add dart doc
  double temp = 32;

  /// add dart doc
  String mode = "°F";

  /// add dart doc
  void setTemp(double t) {
    temp = t;
  }

  /// add dart doc
  void toggle() {
    if (mode == "°F") {
      mode = "°C";
    } else {
      mode = "°F";
    }
  }

  /// add dart doc
  double convert() {
    // if temp less than -500 (absolute zero), set to -500
    if (temp < -500) {
      temp = -500;
    }
    // if mode is °F, then convert by subtracting 32
    // and then multiplying by 5 / 9
    if (mode == "°F") {
      return (temp - 32) * 5 / 9;
    } else {
      // otherwise multiply by 9 / 5 and
      // then add 32 to the result
      return (temp * 9 / 5) + 32;
    }
  }

  /// add dart toc
  String convertString() {
    return convert().toStringAsFixed(1) + (mode == "°F" ? "°C" : "°F");
  }
}
