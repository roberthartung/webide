library webide.widgets.accordion.item;

import 'package:polymer/polymer.dart';

@CustomTag('wi-accordion-item')
class WiAccordionItem extends PolymerElement {
  @published String label;
  
  WiAccordionItem.created() : super.created() {
    print(this.toString() + " created");
  }
  
  void enteredView() {
    super.enteredView();
  }

  @override
  void ready() {
    super.ready();
  }
}