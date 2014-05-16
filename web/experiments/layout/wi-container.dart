library webide.layout.container;

import 'package:polymer/polymer.dart';
import 'wi-splitter.dart';
import 'dart:html';

@CustomTag('wi-container')
class WiContainer extends PolymerElement {

  MutationObserver _observer;
  
  WiContainer.created() : super.created() {
    _observer = new MutationObserver(_onMutation);
    _observer.observe(this, childList: true);
  }
  
  _onMutation(List<MutationRecord> changes, MutationObserver) {
    notifyPropertyChange(#observableChildren, null, children);
    Observable.dirtyCheck();
  }
  
  @published bool horizontal = false;
  
  @published bool vertical = false;
  
  @published bool resizable = false;
  
  @observable List get observableChildren => children; 
  
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