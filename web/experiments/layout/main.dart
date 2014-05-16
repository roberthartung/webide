import 'package:polymer/polymer.dart';

import 'dart:html';

@initMethod
void main() {
  ButtonElement add = querySelector('#add');
  ButtonElement remove = querySelector('#remove');
  HtmlElement container = querySelector('#container');
  
  add.onClick.listen((MouseEvent e) {
    container.append(new Element.tag('wi-dock'));
  });
  
  remove.onClick.listen((MouseEvent e) {
    container.children.removeLast();
  });
}