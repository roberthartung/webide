library webide.widgets.timeline;

// TODO(roberthartung): fix css theme file path

import 'package:polymer/polymer.dart';
import 'dart:html';
import 'wi-timeline-element.dart';
import 'dart:collection';

import 'package:webide/themes/themes.dart';

@CustomTag('wi-timeline')
class WiTimeline extends ThemedElement {
  @observable ObservableMap<Object,String> elementsToLabelMap = toObservable(new LinkedHashMap());
  
  @observable ObservableList objects;
  
  static const int MAX_FRAME_WIDTH = 100;
  
  MutationObserver _observer;
  
  String _grid = "";
  
  @observable String get grid => _grid;
  
  @published String zoom = "1.0";

  WiTimeline.created(): super.created() {
    print(this.toString() + " created");
    _observer = new MutationObserver(_onMutation);
    _observer.observe(this, childList: true, subtree: true);
  }

  void ready() {
    super.ready();
    Polymer.onReady.then((_) {
      children.where((e) => e is WiTimelineElement).forEach(_onElementAdded);
      _generateGrid();
    });
  }
  
  void _onElementAdded(WiTimelineElement e) {
    elementsToLabelMap[e] = e.label;
  }
  
  void _onElementRemoved(WiTimelineElement e) {
    elementsToLabelMap.remove(e);
  }

  void _onMutation(List<MutationRecord> records, MutationObserver observer) {
    for (MutationRecord record in records) {
      record.addedNodes.where((e) => e is WiTimelineElement).forEach(_onElementAdded);
      record.removedNodes.where((e) => e is WiTimelineElement).forEach(_onElementRemoved);
    }
  }
  
  void _generateGrid() {
    CanvasElement bg = new CanvasElement();
    bg.width = (MAX_FRAME_WIDTH * double.parse(zoom)).toInt();
    bg.height = 30;
    CanvasRenderingContext2D ctx = bg.getContext('2d');
    ctx.fillStyle = '#000';
    ctx.fillRect(bg.width/2,0,1,bg.height);
    _grid = bg.toDataUrl("image/png");
    notifyPropertyChange(#grid, "", _grid);
  }
  
  void enteredView() {
    super.enteredView();
  }
}
