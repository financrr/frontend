import 'package:flutter/services.dart';

class InputFormatters {
  const InputFormatters._();

  static FilteringTextInputFormatter password =
      FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9!@#\$&*~]{0,32}$'));
}
