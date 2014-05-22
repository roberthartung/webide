library webide.widgets.tabs.item;

import 'package:polymer/polymer.dart';
import 'dart:html';

@CustomTag('wi-tabs-item')
class WiTabsItem extends PolymerElement {
  @published String label;
  
  @published bool visible = false;
  
  WiTabsItem.created() : super.created() {
    print(this.toString() + " created");
    classes.add('hidden');
  }
  
  void enteredView() {
    super.enteredView();
    print('$this entered view inside $parent');
  }

  @override
  void ready() {
    super.ready();
  }
  
  void setVisible(MouseEvent a, b, c) {
    a.preventDefault();
    visible = !visible;
    classes.toggle('hidden');
    classes.toggle('visible');
  }
}