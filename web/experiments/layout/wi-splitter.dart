library webide.layout.container;

import 'package:polymer/polymer.dart';

@CustomTag('wi-splitter')
class WiSplitter extends PolymerElement {
  WiSplitter.created() : super.created();
  
  @published bool horizontal = false;
    
  @published bool vertical = false;
  
  void enteredView() {
    super.enteredView();
    
    if(horizontal) 
        classes.add('horizontal');
    
    if(vertical)
        classes.add('vertical');
    
    print(this.toString() + " enteredView");
  }

  @override
  void ready() {
    super.ready();
  }
}