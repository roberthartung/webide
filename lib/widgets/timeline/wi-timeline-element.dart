library webide.timeline.element;

import 'package:polymer/polymer.dart';
import 'dart:html';

@CustomTag('wi-timeline-element')
class WiTimelineElement extends PolymerElement {
  @published String label = "";
  
  MutationObserver _observer;
  
  WiTimelineElement.created() : super.created() {
    _observer = new MutationObserver(_onMutation);
  }
  
  void ready() {
    super.ready();
  }
  
  void _onMutation(List<MutationRecord> records, MutationObserver observer) {
    
  }
  
  void enteredView() {
    super.enteredView();
  }
}