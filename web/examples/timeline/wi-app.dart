library webide.app;

import 'package:polymer/polymer.dart';
import 'package:webide/webide.dart';
import 'dart:html';

num i = 0;

class KeyFrame {
  Map properties;
  
  KeyFrame(this.properties);
}

class MyObject {
  Map<int, KeyFrame> keyFrames = {};
  
  String name;
  
  MyObject(this.name) {
    keyFrames = {1:new KeyFrame({"left":50}), 10:new KeyFrame({"left":200})};
  }
}

@CustomTag('wi-app')
class WiApp extends PolymerElement {
  @observable var objects = new ObservableList.from([new MyObject("1"), new MyObject("2"), new MyObject("3")]);
  
  WiApp.created() : super.created() {
    print(this.toString() + " created");
  }
  
  @override
  void enteredView() {
    super.enteredView();
        
    WiTimeline timeline = shadowRoot.querySelector("#timeline");
    
    (querySelector("#add") as ButtonInputElement).onClick.listen((_) {
      WiTimelineElement item = new Element.tag("wi-timeline-element");
      item.label = "object $i";
      i++;
      timeline.children.add(item);
    });
    
    (querySelector("#rm1") as ButtonInputElement).onClick.listen((_) {
       timeline.children.where((e) => e is WiTimelineElement).first.remove();
     });
    
    (querySelector("#rmlast") as ButtonInputElement).onClick.listen((_) {
       timeline.children.last.remove();
     });
  }
}