library webide.layout.weighted;

import 'package:polymer/polymer.dart';
import 'dart:html';

abstract class WeightedElement extends PolymerElement {
  @published num weight = 1.0;
  
  @published bool locked = false;
  
  WeightedElement.created() : super.created();
  
  void weightChanged() {
    style.setProperty('flex-grow', weight.toString());
  }
  
  void enteredView() {
    super.enteredView();
    weightChanged();
  }
}