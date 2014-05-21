library webide.widgets.tabs.item;

import 'package:polymer/polymer.dart';

@CustomTag('wi-tabs-item')
class WiTabsItem extends PolymerElement {
  WiTabsItem.created() : super.created() {
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