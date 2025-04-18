package flashx.textLayout.elements
{
     import flash.events.IEventDispatcher;
     import flash.text.engine.ContentElement;
     import flash.text.engine.GroupElement;
     import flash.utils.getDefinitionByName;
     import flash.utils.getQualifiedClassName;
     import flashx.textLayout.events.FlowElementEventDispatcher;
     import flashx.textLayout.events.ModelChange;
     import flashx.textLayout.tlf_internal;
     
     public class SubParagraphGroupElementBase extends FlowGroupElement
     {
          
          tlf_internal static const kMaxSPGEPrecedence:uint = 1000;
          
          tlf_internal static const kMinSPGEPrecedence:uint = 0;
           
          
          private var _groupElement:GroupElement;
          
          tlf_internal var _eventMirror:FlowElementEventDispatcher = null;
          
          public function SubParagraphGroupElementBase()
          {
               super();
          }
          
          override tlf_internal function createContentElement() : void
          {
               var child:FlowElement = null;
               if(Boolean(this._groupElement))
               {
                    return;
               }
               computedFormat;
               this._groupElement = new GroupElement(null);
               for(var i:int = 0; i < numChildren; i++)
               {
                    child = getChildAt(i);
                    child.tlf_internal::createContentElement();
               }
               if(Boolean(parent))
               {
                    parent.tlf_internal::insertBlockElement(this,this._groupElement);
               }
          }
          
          override tlf_internal function releaseContentElement() : void
          {
               var child:FlowElement = null;
               if(this._groupElement == null)
               {
                    return;
               }
               for(var i:int = 0; i < numChildren; i++)
               {
                    child = getChildAt(i);
                    child.tlf_internal::releaseContentElement();
               }
               this._groupElement = null;
               _computedFormat = null;
          }
          
          tlf_internal function get precedence() : uint
          {
               return tlf_internal::kMaxSPGEPrecedence;
          }
          
          tlf_internal function get groupElement() : GroupElement
          {
               return this._groupElement;
          }
          
          override tlf_internal function getEventMirror() : IEventDispatcher
          {
               if(!this.tlf_internal::_eventMirror)
               {
                    this.tlf_internal::_eventMirror = new FlowElementEventDispatcher(this);
               }
               return this.tlf_internal::_eventMirror;
          }
          
          override tlf_internal function hasActiveEventMirror() : Boolean
          {
               return Boolean(this.tlf_internal::_eventMirror) && this.tlf_internal::_eventMirror.tlf_internal::_listenerCount != 0;
          }
          
          override tlf_internal function appendElementsForDelayedUpdate(tf:TextFlow, changeType:String) : void
          {
               if(changeType == ModelChange.ELEMENT_ADDED)
               {
                    if(this.tlf_internal::hasActiveEventMirror())
                    {
                         tf.tlf_internal::incInteractiveObjectCount();
                    }
               }
               else if(changeType == ModelChange.ELEMENT_REMOVAL)
               {
                    if(this.tlf_internal::hasActiveEventMirror())
                    {
                         tf.tlf_internal::decInteractiveObjectCount();
                    }
               }
               super.tlf_internal::appendElementsForDelayedUpdate(tf,changeType);
          }
          
          override tlf_internal function createContentAsGroup() : GroupElement
          {
               return this.tlf_internal::groupElement;
          }
          
          override tlf_internal function removeBlockElement(child:FlowElement, block:ContentElement) : void
          {
               var idx:int = this.getChildIndex(child);
               this.tlf_internal::groupElement.replaceElements(idx,idx + 1,null);
          }
          
          override tlf_internal function insertBlockElement(child:FlowElement, block:ContentElement) : void
          {
               var idx:int = 0;
               var gc:Vector.<ContentElement> = null;
               var para:ParagraphElement = null;
               if(Boolean(this.tlf_internal::groupElement))
               {
                    idx = this.getChildIndex(child);
                    gc = new Vector.<ContentElement>();
                    gc.push(block);
                    this.tlf_internal::groupElement.replaceElements(idx,idx,gc);
               }
               else
               {
                    child.tlf_internal::releaseContentElement();
                    para = getParagraph();
                    if(Boolean(para))
                    {
                         para.tlf_internal::createTextBlock();
                    }
               }
          }
          
          override tlf_internal function hasBlockElement() : Boolean
          {
               return this.tlf_internal::groupElement != null;
          }
          
          override tlf_internal function setParentAndRelativeStart(newParent:FlowGroupElement, newStart:int) : void
          {
               if(newParent == parent)
               {
                    return;
               }
               if(parent && parent.tlf_internal::hasBlockElement() && Boolean(this.tlf_internal::groupElement))
               {
                    parent.tlf_internal::removeBlockElement(this,this.tlf_internal::groupElement);
               }
               if(newParent && !newParent.tlf_internal::hasBlockElement() && Boolean(this.tlf_internal::groupElement))
               {
                    newParent.tlf_internal::createContentElement();
               }
               super.tlf_internal::setParentAndRelativeStart(newParent,newStart);
               if(Boolean(parent) && Boolean(parent.tlf_internal::hasBlockElement()))
               {
                    if(!this.tlf_internal::groupElement)
                    {
                         this.tlf_internal::createContentElement();
                    }
                    else
                    {
                         parent.tlf_internal::insertBlockElement(this,this.tlf_internal::groupElement);
                    }
               }
          }
          
          override public function replaceChildren(beginChildIndex:int, endChildIndex:int, ... rest) : void
          {
               var applyParams:Array = [beginChildIndex,endChildIndex];
               super.replaceChildren.apply(this,applyParams.concat(rest));
               var p:ParagraphElement = this.getParagraph();
               if(Boolean(p))
               {
                    p.tlf_internal::ensureTerminatorAfterReplace();
               }
          }
          
          override tlf_internal function normalizeRange(normalizeStart:uint, normalizeEnd:uint) : void
          {
               var child:FlowElement = null;
               var origChildEnd:int = 0;
               var newChildEnd:int = 0;
               var prevElement:FlowElement = null;
               var s:SpanElement = null;
               var idx:int = findChildIndexAtPosition(normalizeStart);
               if(idx != -1 && idx < numChildren)
               {
                    child = getChildAt(idx);
                    for(normalizeStart -= child.parentRelativeStart; true; )
                    {
                         origChildEnd = child.parentRelativeStart + child.textLength;
                         child.tlf_internal::normalizeRange(normalizeStart,normalizeEnd - child.parentRelativeStart);
                         newChildEnd = child.parentRelativeStart + child.textLength;
                         normalizeEnd += newChildEnd - origChildEnd;
                         if(child.textLength == 0 && !child.tlf_internal::bindableElement)
                         {
                              this.replaceChildren(idx,idx + 1);
                         }
                         else if(child.tlf_internal::mergeToPreviousIfPossible())
                         {
                              prevElement = this.getChildAt(idx - 1);
                              prevElement.tlf_internal::normalizeRange(0,prevElement.textLength);
                         }
                         else
                         {
                              idx++;
                         }
                         if(idx == numChildren)
                         {
                              break;
                         }
                         child = getChildAt(idx);
                         if(child.parentRelativeStart > normalizeEnd)
                         {
                              break;
                         }
                         normalizeStart = 0;
                    }
               }
               if(numChildren == 0 && parent != null)
               {
                    s = new SpanElement();
                    this.replaceChildren(0,0,s);
                    s.tlf_internal::normalizeRange(0,s.textLength);
               }
          }
          
          tlf_internal function get allowNesting() : Boolean
          {
               return false;
          }
          
          private function checkForNesting(element:SubParagraphGroupElementBase) : Boolean
          {
               var i:int = 0;
               var elementClass:Class = null;
               if(Boolean(element))
               {
                    if(!element.tlf_internal::allowNesting)
                    {
                         elementClass = getDefinitionByName(getQualifiedClassName(element)) as Class;
                         if(this is elementClass || Boolean(this.getParentByType(elementClass)))
                         {
                              return false;
                         }
                    }
                    for(i = element.numChildren - 1; i >= 0; i--)
                    {
                         if(!this.checkForNesting(element.getChildAt(i) as SubParagraphGroupElementBase))
                         {
                              return false;
                         }
                    }
               }
               return true;
          }
          
          override tlf_internal function canOwnFlowElement(elem:FlowElement) : Boolean
          {
               if(elem is FlowLeafElement)
               {
                    return true;
               }
               if(elem is SubParagraphGroupElementBase && this.checkForNesting(elem as SubParagraphGroupElementBase))
               {
                    return true;
               }
               return false;
          }
          
          tlf_internal function acceptTextBefore() : Boolean
          {
               return true;
          }
          
          tlf_internal function acceptTextAfter() : Boolean
          {
               return true;
          }
     }
}
