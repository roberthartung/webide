library optionbox_item_plain1;

import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:async';

import 'dart:mirrors';

/**
 * listbox-item is elements that can be added to the list-box
 *
 * Example:
 *
 *     <listbox-item></listbox-item>
 *
 * @class listbox-item
 */
@CustomTag('optionbox-item-plain1')
class OptionboxItemPlain1 extends PolymerElement {
  /*
   * Set to true to prevent disposal of observable bindings
   */
  bool get preventDispose => true;

  OptionboxItemPlain1.created() : super.created() {
  }

  @override
  void polymerCreated() {
    super.polymerCreated();
  }

  @override
  void ready() {
    super.ready();
  }

  /* Properties */
  @published
  String label = "Label";
}
