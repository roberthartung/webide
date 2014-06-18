import 'package:polymer/polymer.dart';

import 'dart:html';

@initMethod
void main() {
  ButtonElement add = querySelector('#add');
  ButtonElement remove = querySelector('#remove');
  ButtonElement addPanelTabs = querySelector('#add-panel-tabs');
  ButtonElement addPanelAccordion = querySelector('#add-panel-accordion');
  HtmlElement container = querySelector('#container');
  
  add.onClick.listen((MouseEvent e) {
    container.append(new Element.tag('wi-dock'));
  });
  
  remove.onClick.listen((MouseEvent e) {
    container.children.removeLast();
  });
  
  int i = 4;
  
  addPanelTabs.onClick.listen((MouseEvent e) {
    querySelector('#dock4').appendHtml('<wi-panel label="Tab $i">$i</wi-panel>');
    
    i++;
  });
  
  int num = 4;
  addPanelAccordion.onClick.listen((MouseEvent e) {
    querySelector('#dock1').appendHtml('<wi-panel label="Accordion $num">$num</wi-panel>');
    
    num++;
  });
}