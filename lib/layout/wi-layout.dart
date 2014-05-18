library webide.layout;

import 'package:polymer/polymer.dart';

@CustomTag('wi-layout')
class WiLayout extends PolymerElement {
  WiLayout.created() : super.created();
  
  void enteredView() {
    super.enteredView();
    
    print(this.toString() + " enteredView");
  }

  @override
  void ready() {
    super.ready();
  }
}