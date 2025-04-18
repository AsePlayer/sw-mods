package flashx.textLayout.events
{
     import flash.display.DisplayObject;
     import flash.display.DisplayObjectContainer;
     import flash.display.Sprite;
     import flash.events.Event;
     import flash.events.KeyboardEvent;
     import flash.events.MouseEvent;
     import flash.geom.Matrix;
     import flash.geom.Point;
     import flash.geom.Rectangle;
     import flash.ui.Mouse;
     import flash.ui.MouseCursor;
     import flashx.textLayout.elements.*;
     import flashx.textLayout.formats.BlockProgression;
     import flashx.textLayout.tlf_internal;
     import flashx.textLayout.utils.GeometryUtil;
     import flashx.textLayout.utils.HitTestArea;
     
     [ExcludeClass]
     public class FlowElementMouseEventManager
     {
           
          
          private var _container:DisplayObjectContainer;
          
          private var _hitTests:HitTestArea = null;
          
          private var _currentElement:FlowElement = null;
          
          private var _mouseDownElement:FlowElement = null;
          
          private var _needsCtrlKey:Boolean = false;
          
          private var _ctrlKeyState:Boolean = false;
          
          private var _lastMouseEvent:MouseEvent = null;
          
          private var _blockInteraction:Boolean = false;
          
          private const OWNER_HANDLES_EVENT:int = 0;
          
          private const THIS_HANDLES_EVENT:int = 1;
          
          private const THIS_LISTENS_FOR_EVENTS:int = 2;
          
          private var _eventListeners:Object;
          
          private var _hitRects:Object = null;
          
          public function FlowElementMouseEventManager(container:DisplayObjectContainer, eventNames:Array)
          {
               var name:String = null;
               super();
               this._container = container;
               this._eventListeners = {};
               this._eventListeners[MouseEvent.MOUSE_OVER] = this._eventListeners[MouseEvent.MOUSE_OUT] = this._eventListeners[MouseEvent.MOUSE_DOWN] = this._eventListeners[MouseEvent.MOUSE_UP] = this._eventListeners[MouseEvent.MOUSE_MOVE] = this._eventListeners[KeyboardEvent.KEY_DOWN] = this._eventListeners[KeyboardEvent.KEY_UP] = this.THIS_HANDLES_EVENT;
               for each(name in eventNames)
               {
                    this._eventListeners[name] = this.OWNER_HANDLES_EVENT;
               }
          }
          
          public function mouseToContainer(evt:MouseEvent) : Point
          {
               var m:Matrix = null;
               var obj:DisplayObject = evt.target as DisplayObject;
               var containerPoint:Point = new Point(evt.localX,evt.localY);
               while(obj != this._container)
               {
                    m = obj.transform.matrix;
                    containerPoint.offset(m.tx,m.ty);
                    obj = obj.parent;
                    if(!obj)
                    {
                         break;
                    }
               }
               return containerPoint;
          }
          
          public function get needsCtrlKey() : Boolean
          {
               return this._needsCtrlKey;
          }
          
          public function set needsCtrlKey(k:Boolean) : void
          {
               this._needsCtrlKey = k;
          }
          
          public function updateHitTests(xoffset:Number, clipRect:Rectangle, textFlow:TextFlow, startPos:int, endPos:int, needsCtrlKey:Boolean = false) : void
          {
               var rect:Rectangle = null;
               var obj:Object = null;
               var newHitRects:Object = null;
               var element:FlowElement = null;
               var elemStart:int = 0;
               var elemEnd:int = 0;
               var elemRects:Array = null;
               var name:String = null;
               var oldObj:Object = null;
               this._needsCtrlKey = needsCtrlKey;
               var elements:Array = [];
               if(textFlow.tlf_internal::interactiveObjectCount != 0 && startPos != endPos)
               {
                    this.tlf_internal::collectElements(textFlow,startPos,endPos,elements);
               }
               var rectCount:int = 0;
               if(elements.length != 0)
               {
                    newHitRects = {};
                    for each(element in elements)
                    {
                         elemStart = element.getAbsoluteStart();
                         elemEnd = Math.min(elemStart + element.textLength,endPos);
                         elemRects = GeometryUtil.getHighlightBounds(new TextRange(element.getTextFlow(),elemStart,elemEnd));
                         for each(obj in elemRects)
                         {
                              rect = obj.rect;
                              rect.x = clipRect.x + obj.textLine.x + rect.x + xoffset;
                              rect.y = clipRect.y + obj.textLine.y + rect.y;
                              rect = rect.intersection(clipRect);
                              if(!rect.isEmpty())
                              {
                                   rect.x = int(rect.x);
                                   rect.y = int(rect.y);
                                   rect.width = int(rect.width);
                                   rect.height = int(rect.height);
                                   name = rect.toString();
                                   oldObj = newHitRects[name];
                                   if(!oldObj || oldObj.owner != element)
                                   {
                                        newHitRects[name] = {
                                             "rect":rect,
                                             "owner":element
                                        };
                                        rectCount++;
                                   }
                              }
                         }
                    }
               }
               if(rectCount > 0)
               {
                    if(!this._hitTests)
                    {
                         this.tlf_internal::startHitTests();
                    }
                    this._hitRects = newHitRects;
                    this._hitTests = new HitTestArea(newHitRects);
               }
               else
               {
                    this.stopHitTests();
               }
          }
          
          tlf_internal function startHitTests() : void
          {
               this._currentElement = null;
               this._mouseDownElement = null;
               this._ctrlKeyState = false;
               this.addEventListener(MouseEvent.MOUSE_OVER,false);
               this.addEventListener(MouseEvent.MOUSE_OUT,false);
               this.addEventListener(MouseEvent.MOUSE_DOWN,false);
               this.addEventListener(MouseEvent.MOUSE_UP,false);
               this.addEventListener(MouseEvent.MOUSE_MOVE,false);
          }
          
          public function stopHitTests() : void
          {
               this.removeEventListener(MouseEvent.MOUSE_OVER,false);
               this.removeEventListener(MouseEvent.MOUSE_OUT,false);
               this.removeEventListener(MouseEvent.MOUSE_DOWN,false);
               this.removeEventListener(MouseEvent.MOUSE_UP,false);
               this.removeEventListener(MouseEvent.MOUSE_MOVE,false);
               this.removeEventListener(KeyboardEvent.KEY_DOWN,true);
               this.removeEventListener(KeyboardEvent.KEY_UP,true);
               this._hitRects = null;
               this._hitTests = null;
               this._currentElement = null;
               this._mouseDownElement = null;
               this._ctrlKeyState = false;
          }
          
          private function addEventListener(name:String, kbdEvent:Boolean = false) : void
          {
               var target:DisplayObjectContainer = null;
               var listener:Function = null;
               if(this._eventListeners[name] === this.THIS_HANDLES_EVENT)
               {
                    if(kbdEvent)
                    {
                         target = this._container.stage;
                         if(!target)
                         {
                              target = this._container;
                         }
                         listener = this.hitTestKeyEventHandler;
                    }
                    else
                    {
                         target = this._container;
                         listener = this.hitTestMouseEventHandler;
                    }
                    target.addEventListener(name,listener,false,1);
                    this._eventListeners[name] = this.THIS_LISTENS_FOR_EVENTS;
               }
          }
          
          private function removeEventListener(name:String, kbdEvent:Boolean) : void
          {
               var target:DisplayObjectContainer = null;
               var listener:Function = null;
               if(this._eventListeners[name] === this.THIS_LISTENS_FOR_EVENTS)
               {
                    if(kbdEvent)
                    {
                         target = this._container.stage;
                         if(!target)
                         {
                              target = this._container;
                         }
                         listener = this.hitTestKeyEventHandler;
                    }
                    else
                    {
                         target = this._container;
                         listener = this.hitTestMouseEventHandler;
                    }
                    target.removeEventListener(name,listener);
                    this._eventListeners[name] = this.THIS_HANDLES_EVENT;
               }
          }
          
          tlf_internal function collectElements(parent:FlowGroupElement, startPosition:int, endPosition:int, results:Array) : void
          {
               var child:FlowElement = null;
               var group:FlowGroupElement = null;
               for(var i:int = parent.findChildIndexAtPosition(startPosition); i < parent.numChildren; )
               {
                    child = parent.getChildAt(i);
                    if(child.parentRelativeStart >= endPosition)
                    {
                         break;
                    }
                    if(Boolean(child.tlf_internal::hasActiveEventMirror()) || child is LinkElement)
                    {
                         results.push(child);
                    }
                    group = child as FlowGroupElement;
                    if(Boolean(group))
                    {
                         this.tlf_internal::collectElements(group,Math.max(startPosition - group.parentRelativeStart,0),endPosition - group.parentRelativeStart,results);
                    }
                    i++;
               }
          }
          
          public function dispatchEvent(evt:Event) : void
          {
               var keyEvt:KeyboardEvent = null;
               var mouseEvt:MouseEvent = evt as MouseEvent;
               if(Boolean(mouseEvt))
               {
                    this.hitTestMouseEventHandler(mouseEvt);
               }
               else
               {
                    keyEvt = evt as KeyboardEvent;
                    if(Boolean(keyEvt))
                    {
                         this.hitTestKeyEventHandler(keyEvt);
                    }
               }
          }
          
          private function hitTestKeyEventHandler(evt:KeyboardEvent) : void
          {
               if(!this._blockInteraction)
               {
                    this.checkCtrlKeyState(evt.ctrlKey);
               }
          }
          
          private function checkCtrlKeyState(curState:Boolean) : void
          {
               var link:LinkElement = this._currentElement as LinkElement;
               if(!link || !this._needsCtrlKey || !this._lastMouseEvent || curState == this._ctrlKeyState)
               {
                    return;
               }
               this._ctrlKeyState = curState;
               if(this._ctrlKeyState)
               {
                    link.tlf_internal::mouseOverHandler(this,this._lastMouseEvent);
               }
               else
               {
                    link.tlf_internal::mouseOutHandler(this,this._lastMouseEvent);
               }
          }
          
          private function hitTestMouseEventHandler(evt:MouseEvent) : void
          {
               if(!this._hitTests)
               {
                    return;
               }
               this._lastMouseEvent = evt;
               var containerPoint:Point = this.mouseToContainer(evt);
               var hitElement:FlowElement = this._hitTests.hitTest(containerPoint.x,containerPoint.y);
               if(hitElement != this._currentElement)
               {
                    this._mouseDownElement = null;
                    if(Boolean(this._currentElement))
                    {
                         this.localDispatchEvent(FlowElementMouseEvent.ROLL_OUT,evt);
                    }
                    else if(evt.buttonDown)
                    {
                         this._blockInteraction = true;
                    }
                    this._currentElement = hitElement;
                    if(Boolean(this._currentElement))
                    {
                         this.localDispatchEvent(FlowElementMouseEvent.ROLL_OVER,evt);
                    }
                    else
                    {
                         this._blockInteraction = false;
                    }
               }
               var isClick:Boolean = false;
               var eventType:String = null;
               switch(evt.type)
               {
                    case MouseEvent.MOUSE_MOVE:
                         eventType = FlowElementMouseEvent.MOUSE_MOVE;
                         if(!this._blockInteraction)
                         {
                              this.checkCtrlKeyState(evt.ctrlKey);
                         }
                         break;
                    case MouseEvent.MOUSE_DOWN:
                         this._mouseDownElement = this._currentElement;
                         eventType = FlowElementMouseEvent.MOUSE_DOWN;
                         break;
                    case MouseEvent.MOUSE_UP:
                         eventType = FlowElementMouseEvent.MOUSE_UP;
                         isClick = this._currentElement == this._mouseDownElement;
                         this._mouseDownElement = null;
               }
               if(Boolean(this._currentElement) && Boolean(eventType))
               {
                    this.localDispatchEvent(eventType,evt);
                    if(isClick)
                    {
                         this.localDispatchEvent(FlowElementMouseEvent.CLICK,evt);
                    }
               }
          }
          
          tlf_internal function dispatchFlowElementMouseEvent(type:String, originalEvent:MouseEvent) : Boolean
          {
               if(this._needsCtrlKey && !originalEvent.ctrlKey && type != FlowElementMouseEvent.ROLL_OUT)
               {
                    return false;
               }
               var locallyListening:Boolean = Boolean(this._currentElement.tlf_internal::hasActiveEventMirror());
               var textFlow:TextFlow = this._currentElement.getTextFlow();
               var textFlowListening:Boolean = false;
               if(Boolean(textFlow))
               {
                    textFlowListening = textFlow.hasEventListener(type);
               }
               if(!locallyListening && !textFlowListening)
               {
                    return false;
               }
               var event:FlowElementMouseEvent = new FlowElementMouseEvent(type,false,true,this._currentElement,originalEvent);
               if(locallyListening)
               {
                    this._currentElement.tlf_internal::getEventMirror().dispatchEvent(event);
                    if(event.isDefaultPrevented())
                    {
                         return true;
                    }
               }
               if(textFlowListening)
               {
                    textFlow.dispatchEvent(event);
                    if(event.isDefaultPrevented())
                    {
                         return true;
                    }
               }
               return false;
          }
          
          private function localDispatchEvent(type:String, evt:MouseEvent) : void
          {
               if(this._blockInteraction || !this._currentElement)
               {
                    return;
               }
               if(this._needsCtrlKey)
               {
                    switch(type)
                    {
                         case FlowElementMouseEvent.ROLL_OVER:
                              this.addEventListener(KeyboardEvent.KEY_DOWN,true);
                              this.addEventListener(KeyboardEvent.KEY_UP,true);
                              break;
                         case FlowElementMouseEvent.ROLL_OUT:
                              this.removeEventListener(KeyboardEvent.KEY_DOWN,true);
                              this.removeEventListener(KeyboardEvent.KEY_UP,true);
                    }
               }
               if(this.tlf_internal::dispatchFlowElementMouseEvent(type,evt))
               {
                    return;
               }
               var link:LinkElement = !this._needsCtrlKey || evt.ctrlKey ? this._currentElement as LinkElement : null;
               if(!link)
               {
                    return;
               }
               switch(type)
               {
                    case FlowElementMouseEvent.MOUSE_DOWN:
                         link.tlf_internal::mouseDownHandler(this,evt);
                         break;
                    case FlowElementMouseEvent.MOUSE_MOVE:
                         link.tlf_internal::mouseMoveHandler(this,evt);
                         break;
                    case FlowElementMouseEvent.ROLL_OUT:
                         link.tlf_internal::mouseOutHandler(this,evt);
                         break;
                    case FlowElementMouseEvent.ROLL_OVER:
                         link.tlf_internal::mouseOverHandler(this,evt);
                         break;
                    case FlowElementMouseEvent.MOUSE_UP:
                         link.tlf_internal::mouseUpHandler(this,evt);
                         break;
                    case FlowElementMouseEvent.CLICK:
                         link.tlf_internal::mouseClickHandler(this,evt);
               }
          }
          
          tlf_internal function setHandCursor(state:Boolean = true) : void
          {
               var sprite:Sprite = null;
               var wmode:String = null;
               if(this._currentElement == null)
               {
                    return;
               }
               var tf:TextFlow = this._currentElement.getTextFlow();
               if(tf != null && tf.flowComposer && Boolean(tf.flowComposer.numControllers))
               {
                    sprite = this._container as Sprite;
                    if(Boolean(sprite))
                    {
                         sprite.buttonMode = state;
                         sprite.useHandCursor = state;
                    }
                    if(state)
                    {
                         Mouse.cursor = MouseCursor.BUTTON;
                    }
                    else
                    {
                         wmode = String(tf.computedFormat.blockProgression);
                         if(Boolean(tf.interactionManager) && wmode != BlockProgression.RL)
                         {
                              Mouse.cursor = MouseCursor.IBEAM;
                         }
                         else
                         {
                              Mouse.cursor = MouseCursor.AUTO;
                         }
                    }
                    Mouse.hide();
                    Mouse.show();
               }
          }
     }
}
