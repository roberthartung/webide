library webide.layout.weighted;

import 'package:polymer/polymer.dart';

abstract class Weighted {
  @published int weight = 1;
  
  void setWeight();
  
  void weightChanged() {
    setWeight();
  }
}