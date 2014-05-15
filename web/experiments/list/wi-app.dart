library webide.app;

import 'package:polymer/polymer.dart';

class SomeObject extends Observable {
  @observable String label;
  
  SomeObject(this.label);
  
  String toString() => label;
}

int i = 4;

@CustomTag('wi-app')
class WiApp extends PolymerElement {
  @observable ObservableList objects = new ObservableList.from([new SomeObject("Mixed #1"), new SomeObject("Mixed #2"), new SomeObject("Mixed #3")]);
  
  @observable ObservableList objects2 = new ObservableList.from([new SomeObject("Dynamic #1"), new SomeObject("Dynamic #2"), new SomeObject("Dynamic #3")]);
  
  WiApp.created() : super.created() {
    
  }

  @override
  void polymerCreated() {
    super.polymerCreated();
    print("polymerCreated");
  }

  @override
  void ready() {
    print("ready");
    super.ready();
  }
  
  void addObject() {
    objects.add(new SomeObject("Object #$i"));
    i++;
  }
}
