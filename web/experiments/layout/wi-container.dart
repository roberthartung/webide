library webide.layout.container;

import 'package:polymer/polymer.dart';

@CustomTag('wi-container')
class WiContainer extends PolymerElement {
  WiContainer.created() : super.created();
  
  @published bool horizontal = false;
  
  @published bool vertical = false;
  
  void enteredView() {
    super.enteredView();
    
    print(this.toString() + " enteredView");
    
    if(horizontal) 
        classes.add('horizontal');
    
    if(vertical)
        classes.add('vertical');
  }

  @override
  void ready() {
    super.ready();
  }
}