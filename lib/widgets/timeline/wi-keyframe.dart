library webide.widgets.timeline.keyframe;

import 'package:polymer/polymer.dart';

@CustomTag('wi-keyframe')
class WiKeyframe extends PolymerElement {
  @published int at;
  
  WiKeyframe.created() : super.created() {
    
  }
  
  @override
  void enteredView() {
    super.enteredView();
  }
}