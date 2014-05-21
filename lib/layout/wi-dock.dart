library webide.layout.dock;

import 'package:polymer/polymer.dart';
import 'weighted_element.dart';
import 'dart:html';
import '../modals/wi-panel.dart';

@CustomTag('wi-dock')
class WiDock extends WeightedElement {
  MutationObserver _observer;
  
  List<WiPanel> _children = new ObservableList.from([]);
  
  // @observable List<WiPanel> get observableChildren => _children;
  
  @observable Iterable<Element> get observableChildren => children.where((e) => (e is WiPanel));
  
  @published bool tabbed = false;
  
  @published bool accordion = false;
  
  WiDock.created() : super.created() {
    _observer = new MutationObserver(_onMutation);
    _observer.observe(this, childList: true);
    /*
    Polymer.onReady.then((_) {
      children.forEach((e) {
        if(e is WiPanel) {
          _children.add(e as WiPanel);
        }
      });
      notifyPropertyChange(#observableChildren, null, _children);
      deliverChanges();
    });
    */
  }
  
  _onMutation(List<MutationRecord> changes, MutationObserver) {
    changes.forEach((MutationRecord change) {
      /*
      change.addedNodes.forEach((e) {
        if(e is WiPanel) {
          _children.add(e as WiPanel);
        }
      });
      
      change.removedNodes.forEach((e) {
        if(e is WiPanel) {
          _children.remove(e);
        }
      });
      */
      notifyPropertyChange(#observableChildren, change.oldValue, children);
    });
    deliverChanges();
  }
  
  void enteredView() {
    super.enteredView();
    assert((tabbed || accordion) && !(tabbed && accordion));
    if(accordion)
      classes.add('accordion');
    
    if(tabbed)
      classes.add('tabbed');
  }

  @override
  void ready() {
    super.ready();
  }
}