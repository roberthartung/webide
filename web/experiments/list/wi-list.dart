library webide.list;

import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:async';

import 'wi_sortable_element.dart';

class DraggableStreams {
  StreamSubscription dragStart;
  StreamSubscription dragEnd;
  StreamSubscription dragEnter;
  StreamSubscription dragOver;
  StreamSubscription dragLeave;
  StreamSubscription drop;
}

@CustomTag('wi-list')
class WiList extends PolymerElement {
  bool get preventDispose => true;
  
  MutationObserver _observer;
  
  Map<HtmlElement, DraggableStreams> _dragStreams = new Map<HtmlElement, DraggableStreams>();
  
  @published ObservableList list;
  
  WiList.created(): super.created() {
    
  }
  
  @override
  void polymerCreated() {
    super.polymerCreated();
  }

  @override
  void enteredView() {
    super.enteredView();
    for(Element e in this.children) {
      if(e is HtmlElement) {
        _registerDragListeners(e);
      }
    }
  }

  @override
  void ready() {
    super.ready();
    
    _observer = new MutationObserver(_onMutation);
    _observer.observe(this, childList: true);
  }
  
  void _registerDragListeners(HtmlElement e) {
    if(!_dragStreams.containsKey(e)) {
      DraggableStreams streams = new DraggableStreams();
      e.draggable = true;
      streams.dragStart = e.onDragStart.listen(_onDragStart);
      streams.dragEnd = e.onDragEnd.listen(_onDragEnd);
      streams.dragEnter = e.onDragEnter.listen(_onDragEnter);
      streams.dragLeave = e.onDragLeave.listen(_onDragLeave);
      streams.dragOver = e.onDragOver.listen(_onDragOver);
      streams.drop = e.onDrop.listen(_onDrop);
      _dragStreams[e] = streams;
    }
  }
  
  void _unregisterDragListeners(HtmlElement e) {
    DraggableStreams streams = _dragStreams.remove(e);
    if(streams != null) {
      print('unregister');
      streams.dragStart.cancel();
      streams.dragEnd.cancel();
      streams.dragEnter.cancel();
      streams.dragLeave.cancel();
      streams.dragOver.cancel();
      streams.drop.cancel();
    }
  }
  
  void _onMutation(records, observer) {
    for (MutationRecord record in records) {
      for (Node node in record.addedNodes) {
        if (node is HtmlElement) {
          _registerDragListeners(node);
        }
      }
      for (Node node in record.removedNodes) {
        if (node is HtmlElement) {
          _unregisterDragListeners(node);
        }
      }
    }
  }
  
  static WiSortableElement _draggedElement;
  
  static Element _draggedStaticElement;
  
  _onDragStart(MouseEvent e) {
    //e.dataTransfer.effectAllowed = 'move';
    if((e.target is WiSortableElement) && list != null && list.indexOf((e.target as WiSortableElement).item) != -1) {
      _draggedElement = (e.target as WiSortableElement);
    } else {
      print('dragstart on static element');
      _draggedStaticElement = e.target as Element;
    }
  }
  
  _onDragEnd(MouseEvent e) {
    print('dragEnd');
    _draggedElement = null;
  }
  
  _onDragEnter(MouseEvent e) {
    //print(e);
  }
  
  _onDragLeave(MouseEvent e) {
    //print(e);
  }
  
  _onDragOver(MouseEvent e) {
    e.preventDefault();
    if((e.target is WiSortableElement) && (e.target as WiSortableElement).item != null) {
      if(_draggedElement != null) {
        int draggedElementIndex = list.indexOf(_draggedElement.item);
        int dragOverIndex = list.indexOf((e.target as WiSortableElement).item);
        if(draggedElementIndex == -1) {
          if(dragOverIndex != -1) {
            list.insert(dragOverIndex+1, _draggedElement.item);
          }
        } else {
          if(dragOverIndex != -1 && dragOverIndex != draggedElementIndex) {
            list.removeAt(draggedElementIndex);
            list.insert(dragOverIndex, _draggedElement.item);
          }
        }
        
      }
    } else {
      print('dragover on dynamic element');
      
      (e.target as Element).parent.insertBefore(_draggedStaticElement, (e.target as Element).nextElementSibling);
    }
    
    e.dataTransfer.effectAllowed = 'move';
    return false;
  }
  
  _onDrop(MouseEvent e) {
    e.stopPropagation();
    print('drop');
    _draggedElement = null;
  }
}
