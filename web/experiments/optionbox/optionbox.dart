library list;

import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:async';

import 'dart:mirrors';

import '../selector/selector.dart';

part 'optionbox_item.dart';

/*
 * TODO:
 * Implement static html addition of list-items
 */

class OptionBoxDraggableStreams {
  StreamSubscription dragStart;
  StreamSubscription dragEnd;
  StreamSubscription dragEnter;
  StreamSubscription dragOver;
  StreamSubscription dragLeave;
  StreamSubscription drop;
}

/**
 * list-box is an element that displays list of details or options.
 *
 * Example:
 *
 *     <list-box multiselect="false"></list-box>
 *
 * @class list-box
 */

@CustomTag('option-box')
class OptionBox extends SelectorHelper {
  /*
   * Set to true to prevent disposal of observable bindings
   */
  bool get preventDispose => true;

  HtmlElement _draggedItem;
  bool _draggedItemSelected = false;
  Map<HtmlElement, OptionBoxDraggableStreams> _dragStreams = new Map<HtmlElement, OptionBoxDraggableStreams>();

  OptionBox.created(): super.created() {
  }

  @override
  void polymerCreated() {
    super.polymerCreated();
  }

  @override
  void enteredView() {
    super.enteredView();
  }

  @override
  void ready() {
    super.ready();

    _observer = new MutationObserver(_onMutation);
    _observer.observe(this, childList: true);

    ContentElement _cntElem = shadowRoot.querySelector("#items");
    this.target = this;
  }

  void _registerDragHandlers(HtmlElement ch) {
    ch.draggable = true;
    if (!_dragStreams.containsKey(ch)) {
      OptionBoxDraggableStreams newStreams = new OptionBoxDraggableStreams();
      newStreams.dragStart = ch.onDragStart.listen(_onDragStart);
      newStreams.dragEnd = ch.onDragEnd.listen(_onDragEnd);
      newStreams.dragEnter = ch.onDragEnter.listen(_onDragEnter);
      newStreams.dragOver = ch.onDragOver.listen(_onDragOver);
      newStreams.dragLeave = ch.onDragLeave.listen(_onDragLeave);
      newStreams.drop = ch.onDrop.listen(_onDrop);

      _dragStreams[ch] = newStreams;
    }
  }

  void _degisterDragHandlers(HtmlElement ch) {
    ch.draggable = false;
    OptionBoxDraggableStreams newStreams = _dragStreams.remove(ch);
    if (newStreams != null) {
      newStreams.dragStart.cancel();
      newStreams.dragEnd.cancel();
      newStreams.dragEnter.cancel();
      newStreams.dragOver.cancel();
      newStreams.dragLeave.cancel();
      newStreams.drop.cancel();
    }
  }

  void _onDragStart(MouseEvent event) {
    Element dragTarget = event.target;
    //dragTarget.classes.add('dragged');
    _draggedItem = dragTarget;
    _draggedItemSelected = isSelected(_draggedItem);
    event.dataTransfer.effectAllowed = 'move';
    event.dataTransfer.setData('text', "");
  }

  void _onDragEnd(MouseEvent event) {
    Element dragTarget = event.target;
    //dragTarget.classes.remove('dragged');
    _draggedItem = null;
    _draggedItemSelected = false;
    for (HtmlElement ch in items) {
      ch.classes.remove('over');
    }
  }

  void _onDragEnter(MouseEvent event) {
    Element dropTarget = event.target;
    dropTarget.classes.add('over');


    // cache the current from element
    /*Element fromElement = _fromElement;

    // update the from element
    _fromElement = event.target;

    // if we are moving within a single sortable element, bail
    if((event.currentTarget as Element).contains(fromElement)) return;*/

    // get the index of the element begin dragged
    int dragIndex = items.indexOf(_draggedItem);

    // get the index of the element being dragged into
    int preIndex = items.indexOf(event.currentTarget);

    // move the dragged element before or after the entered element depending on their positions
    if (dragIndex < preIndex) {
      (event.currentTarget as Element).insertAdjacentElement("afterEnd", _draggedItem);
    } else {
      (event.currentTarget as Element).insertAdjacentElement("beforeBegin", _draggedItem);
    }

    if (_draggedItemSelected) {
      select(_draggedItem);
    }
  }

  void _onDragOver(MouseEvent event) {
    // This is necessary to allow us to drop.
    event.preventDefault();
    event.dataTransfer.dropEffect = 'move';
  }

  void _onDragLeave(MouseEvent event) {
    Element dropTarget = event.target;
    dropTarget.classes.remove('over');
  }

  void _onDrop(MouseEvent event) {
    // Stop the browser from redirecting.
    event.stopPropagation();

    // Don't do anything if dropping onto the same element we're dragging.
    /*Element dropTarget = event.target;
    if (_draggedItem != null && _draggedItem != dropTarget) {
      int ind = children.indexOf(dropTarget);
      children.insert(ind, _draggedItem);
      if(_draggedItemSelected) {
        select(_draggedItem);
      }
    }
    _draggedItem = null;
    _draggedItemSelected = false;
    print("reset _draggedItem");*/
  }

  MutationObserver _observer;
  /*
   * TODO: doesn't work when target is ContentElement. MutationObserver currently doesn't fire
   * when distributed nodes in a ContentElement is mutated.
   */
  void _onMutation(records, observer) {
    for (MutationRecord record in records) {
      for (Node node in record.addedNodes) {
        if (node is HtmlElement) {
          _registerDragHandlers(node);
        }
      }
      //unselect removed nodes
      for (Node node in record.removedNodes) {
        if (node is HtmlElement) {
          _degisterDragHandlers(node);
        }
      }
    }
  }

  @published
  bool sortable = true;

  void sortableChanged() {
    if (sortable) {
      for (HtmlElement el in this.children) {
        _registerDragHandlers(el);
      }
    } else {
      for (HtmlElement el in this.children) {
        _degisterDragHandlers(el);
      }
    }

  }
}
