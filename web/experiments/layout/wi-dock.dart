library webide.layout.dock;

import 'package:polymer/polymer.dart';

@CustomTag('wi-dock')
class WiDock extends PolymerElement {
  WiDock.created() : super.created();
  
  void enteredView() {
    super.enteredView();
    
    print(this.toString() + " enteredView");
  }

  @override
  void ready() {
    super.ready();
  }
}