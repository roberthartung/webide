library splitter;

import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:async';

class DockableSplitterSlideEvent {
  WiSplitter target;
  int delta;
  int offsetPos;
  int pagePos;
  bool vertical;
}

@CustomTag('wi-splitter')
class WiSplitter extends PolymerElement {

  /// Constructor.
  WiSplitter.created() : super.created() {
    //onMouseDown.listen(trackStart);
  }
  
  void ready() {
    
  }

  @published bool vertical = false;
  /// Triggered when [vertical] is externally changed.
  void verticalChanged() {
  }
  
  @published bool locked = false;

  StreamSubscription<MouseEvent> _trackSubscr;
  StreamSubscription<MouseEvent> _trackEndSubscr;
  
  void trackStart(MouseEvent e) {
    // Make active regardless of [locked], to appear responsive.
    classes.add('active');

    if (!locked) {
      // To avoid sticky dragging state
      _trackSubscr = document.onMouseMove.listen(track);
      _trackEndSubscr = document.onMouseUp.listen(trackEnd);
    }
  }

  void track(MouseEvent e) {
    // Recheck [locked], in case it's been changed externally in mid-flight.
    if (!locked) {
      DockableSplitterSlideEvent event = new DockableSplitterSlideEvent();
      event.delta = vertical ? e.movement.x : e.movement.y;
      event.offsetPos = vertical ? e.offset.x : e.offset.y;
      event.pagePos = vertical ? e.page.x : e.page.y;
      event.vertical = vertical;
      event.target = this;
      this.fire("slide", detail: event, toNode: this);
    }
  }

  void trackEnd(MouseEvent e) {
    assert(_trackSubscr != null && _trackEndSubscr != null);
    _trackSubscr.cancel();
    _trackSubscr = null;
    _trackEndSubscr.cancel();
    _trackEndSubscr = null;

    classes.remove('active');
  }
  
  //events
  EventStreamProvider<CustomEvent> _slideEventP =
        new EventStreamProvider<CustomEvent>("slide");
  Stream<CustomEvent> get onSlide => _slideEventP.forTarget(this);
}