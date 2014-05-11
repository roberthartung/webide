library webide.timeline.element;

import 'package:polymer/polymer.dart';
import 'dart:html';

/**
 * A Polymer click counter element.
 */
@CustomTag('wi-timeline-element')
class WiTimelineElement extends PolymerElement {
  MutationObserver _observer;
  
  WiTimelineElement.created() : super.created() {
    print(this.toString() + " created");
  }
  
  void ready() {
    super.ready();
    print(this.toString() + " ready");
    
    _observer = new MutationObserver(_onMutation);
  }
  
  void _onMutation(List<MutationRecord> records, MutationObserver observer) {
    
  }
  
  void enteredView() {
    super.enteredView();
    print(this.toString() + " enteredView");
  }
  
  @published String label = "";
}

