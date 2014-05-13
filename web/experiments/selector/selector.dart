library selector;

import 'dart:html';
import 'dart:collection';
import 'dart:async';
import 'dart:convert' show JSON;

import 'package:polymer/polymer.dart';

/*
 * TODO:
 * 1) implement active element
 * 2) Implement always
 */

class SelectorHelper extends PolymerElement {
  List<Element> _selectedItems = [];
  List get selectedItems => _selectedItems;
  @observable
  Element get selectedItem {
    if (_selectedItems.length > 0) {
      return _selectedItems.last;
    } else {
      return null;
    }
  }

  @published
  void set selected(dynamic arg_selected) {
    if (arg_selected is String) {
      try {
        arg_selected = JSON.decode(arg_selected);
      } catch(e) {
        try {
          int nin = int.parse(arg_selected);
          arg_selected = [nin];
        } catch(e) {
        }
      }
    }
    if (arg_selected is List<int>) {
      clear();
      int length = items.length;
      arg_selected.forEach((index) {
        if (index >= 0 && index < length) {
          setItemSelected(items[index], true);
        }
      });
    }
  }
  List<int> get selected {
    List<int> newInts = new List<int>();
    for(Element item in selectedItems) {
      newInts.add(items.indexOf(item));
    }
    return newInts;
  }

  SelectorHelper.created(): super.created();

  void ready() {
    super.ready();
    this._observer = new MutationObserver(_onMutation);

    if (this.target == null) {
      this.target = this;
    }
  }

  List<Element> get items {
    List nodes;
    if(this.target != null) {
      if (this.target != this) {
        if (this.itemsSelector != null && this.itemsSelector.isNotEmpty) {
          //TODO: consider about getDistributedNodes when target is ContentElement
          nodes = this.target.querySelectorAll(this.itemsSelector);
        } else if(this.target is ContentElement) {
          nodes = (this.target as ContentElement).getDistributedNodes();
        } else {
          nodes = this.target.children;
        }
      } else {
        nodes = (this.$['items'] as ContentElement).getDistributedNodes();
      }
    } else {
      nodes = [];
    }

    //ignore template elements
    return nodes.where((Element e) {
      return e != null && e.localName != 'template';
    }).toList();
  }

  bool isSelected(Element item) {
    return this._selectedItems.indexOf(item) >= 0;
  }

  /**
   * Sets the selected state of [item] to [isSelected] and fires
   * a corresponding 'polymer-select' event with the [CustomEvent.detail] set to
   * a map containing 'item' set to [item] and 'isSelected' set to [isSelected].
   */
  void setItemSelected(Element item, isSelected) {
    if (item != null) {
      if (isSelected && !_selectedItems.contains(item)) {
        this._selectedItems.add(item);
        item.classes.add(selectedClass);
      } else {
        int i = this._selectedItems.indexOf(item);
        if (i >= 0) {
          this._selectedItems.removeAt(i);
          item.classes.remove(selectedClass);
        }
      }

      this.fire('selected', detail: {
        'item': item,
        'isSelected': isSelected
      });
    }
  }

  /**
   * Set the selection state for a given [item]. If the multi property
   * is true, then the selected state of [item] will be toggled; otherwise
   * the [item] will be selected.  Fires a corresponding 'polymer-select' event
   * with the [CustomEvent.detail] set to a map containing 'item' set to [item]
   * and 'isSelected' set to [isSelected]. set to the new selection state for
   * the [item].
   */
  void select(Element item) {
    if (this.multi) {
      this._toggle(item);
    } else {
      if(_selectedItems.length == 1 && _selectedItems[0] != item) {
        this.setItemSelected(_selectedItems[0], false);
      } else if(_selectedItems.length > 1) {
        print("Error: more than 1 element in selectedItems");
      }
      this._toggle(item);
    }
  }

  void clear() {
    List<Element> selItems_l = selectedItems.toList();
    selItems_l.forEach((item) {
      setItemSelected(item, false);
    });
  }

  void _toggle(Element item) {
    this.setItemSelected(item, !this.isSelected(item));
  }

  MutationObserver _observer;
  /*
   * TODO: doesn't work when target is ContentElement. MutationObserver currently doesn't fire
   * when distributed nodes in a ContentElement is mutated.
   */
  void _onMutation(records, observer) {
    for (MutationRecord record in records) {
      /*for(Node node in record.addedNodes) {
      }*/
      //unselect removed nodes
      for (Node node in record.removedNodes) {
        setItemSelected(node, false);
      }
    }
  }

  void activateHandler(Event e) {
    int i = this._findDistributedTarget(e.target, this.items);
    if (i >= 0 && i < items.length) {
      Element item = this.items[i];
      select(item);
    }
  }

  /**
   * Finds the node in [nodes] which is the ancestor of the target
   */
  int _findDistributedTarget(target, nodes) {
    // find first ancestor of target (including itself) that
    // is in nodes, if any
    int i = 0;
    while (target != null && target != this) {
      i = nodes.indexOf(target);
      if (i >= 0) {
        return i;
      }
      target = target.parentNode;
    }
    return -1;
  }

  @published
  Element target = null;

  void targetChanged(old) {
    if (old != null) {
      this._removeListener(old);
      this._observer.disconnect();
    }
    if (this.target != null) {
      this._addListener(this.target);
      this._observer.observe(this.target, childList: true);
      if(old == null) {
        selected = this.attributes["selected"];
      }
    }
  }

  void _addListener(node) {
    node.addEventListener(this.activateEvent, activateHandler);
  }

  void _removeListener(node) {
    node.removeEventListener(this.activateEvent, activateHandler);
  }

  @published
  bool multi = false;

  void multiChanged() {
    if (multi == false) {
      List<Element> selItems_l = _selectedItems.toList();
      selItems_l.forEach((item) {
        if(selectedItems.length != 1) {
          setItemSelected(item, false);
        }
      });
    }
  }

  /**
   * Should there always be a selected item as long as there are elements.
   */
  @published
  bool always = false;

  //Configuration options
  /**
   * The event that would be fired from the item element to indicate
   * it is being selected.
   */
  @published
  String activateEvent = 'click';

  String itemsSelector = '';

  static const String selectedClass = "item-selected";

  //events
  EventStreamProvider<CustomEvent> _changedEventP = new EventStreamProvider<CustomEvent>("selected");
  Stream<CustomEvent> get onSelected =>
   _changedEventP.forTarget(this);
}
