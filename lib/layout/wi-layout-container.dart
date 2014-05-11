library webide.layout.container;

import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:async';

import '../splitter/splitter.dart';

@CustomTag('wi-layout-container')
class WiLayoutContainer extends PolymerElement {

  MutationObserver _observer;
  Map<WiLayoutContainer, StreamSubscription> _streams = new Map<WiLayoutContainer, StreamSubscription>();

  WiLayoutContainer.created(): super.created() {
    _observer = new MutationObserver(_onMutation);
    _observer.observe(this, childList: true);
  }

  void ready() {
    _splitter = shadowRoot.querySelector("#splitter");
    //TODO: fix this: verticalChanged is not called if vertical is set to false initially
    Polymer.onReady.then((_) {
      if (vertical == false) {
        verticalChanged();
      }
      for(WiLayoutContainer cont in children) {
        _registerNewChildContainer(cont);
      }
    });
  }

  @override
  void enteredView() {
    super.enteredView();
  }

  void _registerNewChildContainer(WiLayoutContainer node) {
    node._setParentOrientation(vertical);
    if (_streams.containsKey(node)) {
      StreamSubscription _strm = _streams.remove(node);
      _strm.cancel();
    }
    StreamSubscription _strm = node.onSlide.listen((CustomEvent event) {
      DockableSplitterSlideEvent detail = event.detail;
      int myidx = children.indexOf(node);
      //Spliter should not work for last Container
      if (myidx >= 0 && myidx < children.length - 1) {
        WiLayoutContainer nextCont = children.elementAt(myidx + 1);
        
        print(detail.delta);
        num change = detail.delta >= 0? 0.1: - 0.1;
        node.weight = node.weight + change;

        nextCont.weight = nextCont.weight - change;
      }
    });
    _streams[node] = _strm;
  }

  void _onMutation(List<MutationRecord> records, MutationObserver observer) {
    for (MutationRecord record in records) {
      for (Node node in record.addedNodes) {
        if (node is WiLayoutContainer) {

        } else {
          node.remove();
        }
      }

      for (Node node in record.removedNodes) {
        if (node is WiLayoutContainer) {
          if (_streams.containsKey(node)) {
            StreamSubscription _strm = _streams.remove(node);
            _strm.cancel();
          }
        }
      }
    }
  }

  /**
   * This internal function sets parent orientation. 
   */
  void _setParentOrientation(bool par_vertical) {
    if (par_vertical) {
      shadowRoot.querySelector('#holder').classes.add("parvert");
    } else {
      shadowRoot.querySelector('#holder').classes.remove("parvert");
    }
    _splitter.vertical = !par_vertical;
  }
  
  WiLayoutContainer _lastChild = null;

  @published
  bool vertical = false;

  void verticalChanged() {
    //inform children about orientation change
    for (WiLayoutContainer cont in children) {
      cont._setParentOrientation(vertical);
    }
  }

  @published
  bool locked = false;
  
  /**
   * Lock implicitly if this container is the only container in the parent container.
   * This should be called from the parent.
   */
  bool get implicitlock => _implicitlock;
  bool _implicitlock = false;
  void _setImplicitLock() {
    
  }

  @published
  num weight = 1;

  void weightChanged() {
  }

  void lockedChanged() {
    //TODO: implement locked
  }

  WiSplitter _splitter;

  Stream<CustomEvent> get onSlide => _splitter.onSlide;
}
