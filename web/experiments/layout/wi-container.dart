library webide.layout.container;

import 'package:polymer/polymer.dart';
import 'wi-splitter.dart';
import 'dart:html';
import 'dart:async';
import 'weighted.dart';

class _WiSplitterListeners {
  StreamSubscription<MouseEvent> _onMouseDownSubscription;
  
  StreamSubscription<MouseEvent> _onMouseUpSubscription;
  
  StreamSubscription<MouseEvent> _onMouseMoveSubscription;
  
  WiSplitter splitter;
  
  HtmlElement parent;
  
  HtmlElement before;
  
  HtmlElement after;
  
  Point offset;
  
  _WiSplitterListeners(this.parent, this.splitter) {
    ContentElement contentBefore = splitter.previousElementSibling.previousElementSibling as ContentElement;
    ContentElement contentAfter = splitter.nextElementSibling as ContentElement;
    before = contentBefore.getDistributedNodes().first;
    after = contentAfter.getDistributedNodes().first;
    
    _onMouseDownSubscription = splitter.onMouseDown.listen((e) {
      offset = e.offset;
      // offset from mouse to top of splitter
      
      //print('resize on ${before.id} and ${after.id}');
      
      _onMouseMoveSubscription = document.onMouseMove.listen(splitter.vertical ? _resizeVertical : _resizeHorizontal);
      _onMouseUpSubscription = document.onMouseUp.listen((e) {
        _onMouseMoveSubscription.cancel();
        _onMouseUpSubscription.cancel();
      });
    });
  }
  
  void _resizeHorizontal(MouseEvent e) {
     // Calculate offset to body for both elements
     num totalHeight = before.offsetHeight + after.offsetHeight;
     Point offsetBefore = before.offsetTo(document.body);
     Point offsetAfter = after.offsetTo(document.body);
     // calculate new heights
     // sub offset to make sure e.page.y
     num heightBefore = (e.page.y - offset.y) - (offsetBefore.y);
     num heightAfter = (offsetAfter.y + after.offsetHeight) - (e.page.y - offset.y + splitter.offsetHeight);
     num weightSum = double.parse(before.getComputedStyle().flexGrow) + double.parse(after.getComputedStyle().flexGrow);
     print('$totalHeight $heightBefore $heightAfter $weightSum');
     double weightBefore = (heightBefore / totalHeight) * weightSum;
     double weightAfter = (heightAfter / totalHeight) * weightSum;
     before.style.flex = '$weightBefore $weightBefore ${heightBefore}px'; //  1 ${heightBefore}px
     after.style.flex = '$weightAfter $weightAfter ${heightAfter}px'; //  1 ${heightAfter}px
  }
  
  /**
   * Called when the user moved the mouse
   */
  
  void _resizeVertical(MouseEvent e) {
    // Calculate offset to body for both elements
    num totalWidth = before.offsetWidth + after.offsetWidth;
    Point offsetBefore = before.offsetTo(document.body);
    Point offsetAfter = after.offsetTo(document.body);
    // calculate new heights
    // sub offset to make sure e.page.y
    num widthBefore = (e.page.x - offset.x) - (offsetBefore.x);
    num widthAfter = (offsetAfter.x + after.offsetWidth) - (e.page.x - offset.x + splitter.offsetWidth);
    num weightSum = double.parse(before.getComputedStyle().flexGrow) + double.parse(after.getComputedStyle().flexGrow);
    print('$totalWidth $widthBefore $widthAfter $weightSum');
    double weightBefore = (widthBefore / totalWidth) * weightSum;
    double weightAfter = (widthAfter / totalWidth) * weightSum;
    before.style.flex = '$weightBefore $weightBefore ${widthBefore}px'; //  1 ${widthBefore}px
    after.style.flex = '$weightAfter $weightAfter ${widthAfter}px'; //  1 
  }
}
// TODO(roberthartung): Create Weight Mixin
@CustomTag('wi-container')
class WiContainer extends PolymerElement with Weighted {
  MutationObserver _observer;
  
  MutationObserver _splitterObserver;
  
  Map<WiSplitter,_WiSplitterListeners> splitters = new Map();
  
  WiContainer.created() : super.created() {
    _observer = new MutationObserver(_onMutation);
    _observer.observe(this, childList: true);
    
    _splitterObserver = new MutationObserver((List<MutationRecord> changes, MutationObserver) {
      changes.forEach((MutationRecord change) {
        change.addedNodes.forEach((Node e) {
          if(e is WiSplitter) {
            splitters[e] = new _WiSplitterListeners(this, e);
          }
        });
        
        change.removedNodes.forEach((Node e) {
          if(e is WiSplitter) {
            splitters.remove(e);
          }
        });
      });
    });
    
    _splitterObserver.observe(shadowRoot, childList: true);
  }
  
  void setWeight() {
    style.flexGrow = '$weight';
  }
  
  _onMutation(List<MutationRecord> changes, MutationObserver) {
    notifyPropertyChange(#observableChildren, null, children);
    deliverChanges();
  }
  
  @published bool horizontal = false;
  
  @published bool vertical = false;
  
  @published bool resizable = false;
  
  @observable List<Element> get observableChildren => children; 
  
  void enteredView() {
    super.enteredView();
    
    print(this.toString() + " enteredView");
    
    if(horizontal) 
        classes.add('horizontal');
    
    if(vertical)
        classes.add('vertical');
    
    setWeight();
  }

  @override
  void ready() {
    super.ready();
  }
}