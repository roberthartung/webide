library webide.layout.dock;

import 'package:polymer/polymer.dart';
import 'weighted_element.dart';
import 'dart:html';
import '../modals/wi-panel.dart';
import 'package:webide/nth-child-selector.dart';

@CustomTag('wi-dock')
class WiDock extends WeightedElement with NthChildSelector {
  MutationObserver _observer;
  
  List<WiPanel> _children = new ObservableList.from([]);
  
  @observable Iterable<Element> get observableChildren => children.where((e) => (e is WiPanel));
  
  @published bool tabbed = false;
  
  @published bool accordion = false;
  
  WiDock.created() : super.created() {
    _observer = new MutationObserver(_onMutation);
    _observer.observe(this, childList: true);
    addClasses(children);
  }
  
  _onMutation(List<MutationRecord> changes, MutationObserver) {
    changes.forEach((MutationRecord change) {
      notifyPropertyChange(#observableChildren, change.oldValue, children);
    });
    removeClasses(children);
    addClasses(children);
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