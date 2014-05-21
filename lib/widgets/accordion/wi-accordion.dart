library webide.widgets.accordion;

import 'package:polymer/polymer.dart';
import 'dart:html';

import 'wi-accordion-item.dart';

@CustomTag('wi-accordion')
class WiAccordion extends PolymerElement {
  MutationObserver _observer;
  
  @observable Iterable get items => children.where((e) => e is WiAccordionItem);
  
  WiAccordion.created() : super.created() {
    _observer = new MutationObserver(_onMutation);
    _observer.observe(this, childList: true);
  }
  
  void _onMutation(List<MutationRecord> changes, MutationObserver) {
    changes.forEach((MutationRecord change) {
      notifyPropertyChange(#observableChildren, change.oldValue, children);
    });
    deliverChanges();
  }
  
  void _checkAddedNodes() {
    
  }
  
  void enteredView() {
    super.enteredView();
  }

  @override
  void ready() {
    super.ready();
  }
}