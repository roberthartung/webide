library webide.widgets.accordion.item;

import 'package:polymer/polymer.dart';
import 'dart:html';

@CustomTag('wi-accordion-item')
class WiAccordionItem extends PolymerElement {
  @published String label;
  
  @published bool visible = false;
  
  WiAccordionItem.created() : super.created() {
    print(this.toString() + " created");
    classes.add('hidden');
  }
  
  void enteredView() {
    super.enteredView();
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