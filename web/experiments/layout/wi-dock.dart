library webide.layout.dock;

import 'package:polymer/polymer.dart';
import 'weighted.dart';

@CustomTag('wi-dock')
class WiDock extends PolymerElement with Weighted {
  WiDock.created() : super.created();
  
  void enteredView() {
    super.enteredView();
    print(this.toString() + " enteredView");
  }
  
  void setWeight() {
    //print('WiDock.setWeight=$weight');
    //style.flexGrow = '$weight';
  }

  @override
  void ready() {
    super.ready();
  }
}