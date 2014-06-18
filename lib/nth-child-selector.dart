library webide.nthchildselector;

import 'dart:html';

class NthChildSelector {
  List<Element> _applyFilter(List<Element> children) {
    return children.where((e) => !(e is TemplateElement)).toList();
  }
  
  void addClasses(List<Element> children) {
    children = _applyFilter(children);
    int i = 1;
    children.forEach((Element e) {
      e.classes.add('nth-child-$i');
      i++;
    });
  }
  
  void removeClasses(List<Element> children) {
    children = _applyFilter(children);
    children.forEach((Element e) {
      Iterator<String> it = e.classes.where((String c) => c.startsWith('nth-child-')).iterator;
      while(it.moveNext()) {
        e.classes.remove(it.current);
      }
    });
  }
}