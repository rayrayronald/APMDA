import 'dart:typed_data';

class context {
  // Object context_object;
  //
  // context() {
  //   return ;
  // }
  context() {
    state: 0;
  }
  static int state = 0;

  static callMethod (String temp_string, [List temp_list]) {
    print ( "!!!!!!!!!!!!!!!!!!!!!!!");
    return " ";
  }
}

class JsObject {
  // static FromBrowserObject fromBrowserObject = new FromBrowserObject(0);
  static FromBrowserObject fromBrowserObject(int i) {
    return new FromBrowserObject(0);
  }

}

class FromBrowserObject {
  FromBrowserObject(this.dummy);
  final int dummy;
  // const FromBrowserObject(int i);
  bool get connected => false;
  Uint8List get value => null;

}


// if (js.JsObject.fromBrowserObject(js.context.state).connected){
