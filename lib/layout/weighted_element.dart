library webide.layout.weighted;

import 'package:polymer/polymer.dart';

abstract class WeightedElement extends PolymerElement {
  @published num weight = 1.0;
  
  @published bool locked = false;
  
  WeightedElement.created() : super.created();
}