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
    _holder = shadowRoot.querySelector("#holder");
    //TODO: fix this: verticalChanged is not called if vertical is set to false initially
    Polymer.onReady.then((_) {
      if (vertical == false) {
        verticalChanged();
      }
      for (WiLayoutContainer cont in children) {
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
        
        num total_weight = node.weight + nextCont.weight;
        
        //This works because there are no elements with position = relative between parent's holder and
        //and its children.
        if(vertical) {
          num total_dim = node.offsetHeight + nextCont.offsetHeight;
          node.weight = ((detail.offsetPos - node.offsetTop)/total_dim) * total_weight;
          nextCont.weight = ((nextCont.offsetTop + nextCont.offsetHeight - detail.offsetPos)/total_dim) * total_weight;
          print("");
          print(node.offsetTop.toString() + " " + detail.offsetPos.toString() + " " + (nextCont.offsetTop + nextCont.offsetHeight).toString());
        } else {
          num total_dim = node.offsetWidth + nextCont.offsetWidth;
          node.weight = ((detail.offsetPos - node.offsetLeft)/total_dim) * total_weight;
          nextCont.weight = ((nextCont.offsetLeft + nextCont.offsetWidth - detail.offsetPos)/total_dim) * total_weight;
        }
        print(node.weight + nextCont.weight);
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
      _holder.classes.add("parvert");
    } else {
      _holder.classes.remove("parvert");
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
  DivElement _holder;

  Stream<CustomEvent> get onSlide => _splitter.onSlide;
}
