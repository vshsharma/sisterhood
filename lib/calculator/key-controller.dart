import 'dart:async';

import 'package:sisterhood_app/calculator/calculator-key.dart';

class CalKeyEvent {
  CalKeyEvent(this.key);
  final CalculatorKey key;
}

abstract class KeyController {
  static StreamController _controller = StreamController();
  static Stream get _stream => _controller.stream;

  static StreamSubscription listen(Function handler) =>
      _stream.listen(handler as dynamic);
  static void fire(CalKeyEvent event) => _controller.add(event);

  static dispose() => _controller.close();
}
