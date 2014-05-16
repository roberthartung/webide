library webide.layout.container;

import 'package:polymer/polymer.dart';
import 'wi-splitter.dart';
import 'dart:html';

@CustomTag('wi-container')
class WiContainer extends PolymerElement {
  WiContainer.created() : super.created();
  
  @published bool horizontal = false;
  
  @published bool vertical = false;
  
  @published bool resizable = false;
  
  void enteredView() {
    super.enteredView();
    
    print(this.toString() + " enteredView");
    
    if(horizontal) 
        classes.add('horizontal');
    
    if(vertical)
        classes.add('vertical');
    
    if(resizable) {
      Polymer.onReady.then((_) {
        List<Element> _children = [];
        Iterator it = children.skip(1).iterator;
        while(it.moveNext()) {
          _children.add(it.current);
        }
        
        _children.forEach((Element e) {
          WiSplitter splitter = new Element.tag('wi-splitter');
          splitter.attributes['horizontal'] = horizontal ? 'true' : 'false';
          splitter.attributes['vertical'] = vertical ? 'true' : 'false';
          e.parent.insertBefore(splitter, e);
        });
      });
    }
  }

  @override
  void ready() {
    super.ready();
  }
}