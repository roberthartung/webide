library webide.element;

import 'package:polymer/polymer.dart';
import 'wi_sortable_element.dart';

@CustomTag('wi-element')
class WiElement extends PolymerElement with WiSortableElement {
  bool get preventDispose => true;
  
  WiElement.created() : super.created() {
    onClick.listen((e) {
      print(e);
    });
  }
  
  @published String label;

  @override
  void polymerCreated() {
    super.polymerCreated();
  }

  @override
  void ready() {
    super.ready();
  }
}
