library webide.timeline;

import 'package:polymer/polymer.dart';
import 'dart:html';
import 'wi-timeline-element.dart';
import 'dart:collection';
//import 'dart:async';

/**
 * A Polymer click counter element.
 */
@CustomTag('wi-timeline')
class WiTimeline extends PolymerElement {

  MutationObserver _observer;

  WiTimeline.created(): super.created() {
    print(this.toString() + " created");
    _observer = new MutationObserver(_onMutation);
    _observer.observe(this, childList: true, subtree: true);
    //_observer.observe(this.shadowRoot, childList: true, subtree: true);
  }

  void ready() {
    super.ready();
    print(this.toString() + " ready");
    Polymer.onReady.then((_) {
      children.where((e) => e is WiTimelineElement).forEach(_onElementAdded);
    });
  }
  
  void _onElementAdded(WiTimelineElement e) {
    objectToTitleMap[e] = e.label;
  }
  
  void _onElementRemoved(WiTimelineElement e) {
    objectToTitleMap.remove(e);
  }

  void _onMutation(List<MutationRecord> records, MutationObserver observer) {
    for (MutationRecord record in records) {
      record.addedNodes.where((e) => e is WiTimelineElement).forEach(_onElementAdded);
      record.removedNodes.where((e) => e is WiTimelineElement).forEach(_onElementRemoved);
    }
  }
  
  void enteredView() {
    super.enteredView();
    print(this.toString() + " enteredView");
  }

  @observable ObservableMap<Object,String> objectToTitleMap = toObservable(new LinkedHashMap());
  
  //@observable  ObservableList<String> titles = new ObservableList<String>();
}
