library webide.layout.panel;

import 'package:polymer/polymer.dart';

@CustomTag('wi-panel')
class WiPanel extends PolymerElement {
  @published String label = "";
  
  WiPanel.created() : super.created();
  
  void enteredView() {
    super.enteredView();
  }

  @override
  void ready() {
    super.ready();
  }
}