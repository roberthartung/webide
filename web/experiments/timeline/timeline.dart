library main;

import "package:polymer/polymer.dart";
import "dart:html";

import 'wi-timeline-element.dart';
import 'wi-timeline.dart';

num i = 0;

class KeyFrame {
  Map properties;
  
  KeyFrame(this.properties);
}

class MyObject {
  Map<int, KeyFrame> keyFrames = {};
  
  MyObject() {
    keyFrames = {1:new KeyFrame({"left":50}), 10:new KeyFrame({"left":200})};
  }
}

final List<MyObject> objects = [new MyObject(), new MyObject(), new MyObject()];

@initMethod
main() {
  // Assume I have some list from somewhere:
  WiTimeline timeline = querySelector("#timeline");
    
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