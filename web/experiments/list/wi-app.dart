library webide.app;

import 'package:polymer/polymer.dart';

class SomeObject extends Observable {
  @observable String label;
  
  SomeObject(this.label);
}

int i = 4;

@CustomTag('wi-app')
class WiApp extends PolymerElement {
  @observable ObservableList objects = new ObservableList.from([new SomeObject("Object #1"), new SomeObject("Object #2"), new SomeObject("Object #3")]);
  
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
