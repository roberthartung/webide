library webide.widgets.timeline.item;

import 'package:polymer/polymer.dart';

@CustomTag('wi-timeline-item')
class WiTimelineItem extends PolymerElement {
  @published String label;
  
  WiTimelineItem.created() : super.created() {
    
  }
  
  @override
  void enteredView() {
    super.enteredView();
  }
}