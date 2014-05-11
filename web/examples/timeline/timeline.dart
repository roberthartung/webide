library main;

import "package:polymer/polymer.dart";
import "dart:html";
import 'wi-app.dart';
import 'package:webide/webide.dart';

@initMethod
main() {
  // Binding objects to our timeline can be done in two parts
  // a) Use the WiTimelineWrapper class that takes an observable
  // Is this too much magic?
  // b) Use data binding
  // Only possible if the user defines his own tag!
  
  print(themeManager);
  WiApp app = querySelector('wi-app');
}