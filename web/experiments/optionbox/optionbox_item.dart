part of list;

/**
 * listbox-item is elements that can be added to the list-box
 *
 * Example:
 *
 *     <listbox-item></listbox-item>
 *
 * @class listbox-item
 */
@CustomTag('optionbox-item')
class OptionboxItem extends PolymerElement {
  /*
   * Set to true to prevent disposal of observable bindings
   */
  bool get preventDispose => true;

  OptionboxItem.created() : super.created() {
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

  @published
  int height = 24;

  void heightChanged() {

  }
}
