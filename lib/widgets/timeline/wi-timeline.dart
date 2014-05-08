library webide.widgets.timeline;

import 'package:polymer/polymer.dart';
import 'package:webide/wi-object.dart';

@CustomTag('wi-timeline')
class WiTimeline extends PolymerElement {
  @observable List<WiObject> objects = toObservable(new List());
  
  WiTimeline.created() : super.created() {
    
  }
  
  @override
  void enteredView() {
    super.enteredView();
  }
  
  void setObjects(List<WiObject> o) {
    objects = toObservable(o);
  }
}