library webide.layout.weighted;

import 'package:polymer/polymer.dart';

abstract class Weighted extends PolymerElement {
  @published num weight = 1.0;
  
  @published bool locked = false;
  
  Weighted.created() : super.created();
  
  void weightChanged() {
    // ...
  }
}