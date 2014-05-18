library webide.layout.dock;

import 'package:polymer/polymer.dart';
import 'weighted.dart';

@CustomTag('wi-dock')
class WiDock extends Weighted {
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