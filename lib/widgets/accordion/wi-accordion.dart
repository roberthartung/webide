library webide.widgets.accordion;

import 'package:polymer/polymer.dart';
import 'dart:html';

import 'wi-accordion-item.dart';

@CustomTag('wi-accordion')
class WiAccordion extends PolymerElement {
  MutationObserver _observer;
  
  @observable Iterable get items => children.where((e) => e is WiAccordionItem);
  
  @observable int get skipItems => (children.length > 0 && children.first is TemplateElement) ? 1 : 0; 
  
  WiAccordion.created() : super.created() {
    _observer = new MutationObserver(_onMutation);
    _observer.observe(this, childList: true);
  }
  
  void _onMutation(List<MutationRecord> changes, MutationObserver) {
    changes.forEach((MutationRecord change) {
      notifyPropertyChange(#items, change.oldValue, children);
    });
    notifyPropertyChange(#skipItems, -1, skipItems);
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