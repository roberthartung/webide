library webide.widgets.tabs;

import 'package:polymer/polymer.dart';
import 'dart:html';
import 'wi-tabs-item.dart';
import 'package:webide/nth-child-selector.dart';

@CustomTag('wi-tabs')
class WiTabs extends PolymerElement with NthChildSelector {
  MutationObserver _observer;
    
  @observable Iterable<Element> get items => children.where((e) => e is WiTabsItem);
    
  WiTabs.created() : super.created() {
    addClasses(children);
    _observer = new MutationObserver(_onMutation);
    _observer.observe(this, childList: true);
  }
  
  void _onMutation(List<MutationRecord> changes, MutationObserver) {
    changes.forEach((MutationRecord change) {
      notifyPropertyChange(#items, change.oldValue, children);
    });
    removeClasses(children);
    addClasses(children);
    deliverChanges();
  }
  
  void enteredView() {
    super.enteredView();
  }

  @override
  void ready() {
    super.ready();
  }
  
  Map classFilter(Map m) {
    Map _filtered = new Map();
    
    m.forEach((k,v) {
      if(v)
        _filtered[k] = v;
    });
    
    return _filtered;
  }
}