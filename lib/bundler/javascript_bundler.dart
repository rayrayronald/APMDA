@JS()
library javascript_bundler;
import 'dart:js' as js;
import 'package:js/js.dart';

@JS('confirm')
external void showConfirm(String text);

@JS('v')
class V {
  @JS('camelCase')
  external static String camelCase(String text);
}

String toCamelCase(String text) => V.camelCase(text);

void test_function() {
  // js.context.callMethod('alertMessage', ['Flutter is calling upon JavaScript!']);
  //
  // js.context.callMethod('test_function');
}