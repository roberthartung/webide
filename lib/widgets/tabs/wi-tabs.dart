library webide.widgets.tabs;

import 'package:polymer/polymer.dart';
import 'dart:html';
import 'wi-tabs-item.dart';
import 'package:webide/nth-child-selector.dart';
import 'package:template_binding/template_binding.dart' as tb;

@CustomTag('wi-tabs')
class WiTabs extends PolymerElement with NthChildSelector {
  MutationObserver _observer;
    
  @observable Iterable<Element> get items => children.where((e) => e is WiTabsItem);
    
  WiTabsItem _visibleItem = null;
  
  WiTabs.created() : super.created() {
    addClasses(children);
    _observer = new MutationObserver(_onMutation);
    _observer.observe(this, childList: true);
  }
  
  void _onMutation(List<MutationRecord> changes, MutationObserver) {
    if(_visibleItem == null && items.length > 0) {
      _visibleItem = items.first;
      _visibleItem.setVisible(true);
    }
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
  
  void setVisible(MouseEvent e, b, c) {
    e.preventDefault();
    if(_visibleItem != null)
      _visibleItem.setVisible(false);
    
    tb.TemplateInstance ti = tb.nodeBind(e.target).templateInstance;
    WiTabsItem item = ti.model.value as WiTabsItem;
    item.setVisible(true);
    _visibleItem = item;
  }
}