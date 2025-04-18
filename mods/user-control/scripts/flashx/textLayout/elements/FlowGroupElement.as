package flashx.textLayout.elements
{
     import flash.text.engine.ContentElement;
     import flash.text.engine.GroupElement;
     import flash.utils.getQualifiedClassName;
     import flashx.textLayout.compose.FlowDamageType;
     import flashx.textLayout.container.ContainerController;
     import flashx.textLayout.events.ModelChange;
     import flashx.textLayout.formats.FormatValue;
     import flashx.textLayout.formats.ITextLayoutFormat;
     import flashx.textLayout.tlf_internal;
     
     [DefaultProperty("mxmlChildren")]
     public class FlowGroupElement extends flashx.textLayout.elements.FlowElement
     {
           
          
          private var _childArray:Array;
          
          private var _singleChild:flashx.textLayout.elements.FlowElement;
          
          private var _numChildren:int;
          
          public function FlowGroupElement()
          {
               super();
               this._numChildren = 0;
          }
          
          private static function getNestedArgCount(obj:Object) : uint
          {
               return obj is Array ? uint(obj.length) : 1;
          }
          
          private static function getNestedArg(obj:Object, index:uint) : flashx.textLayout.elements.FlowElement
          {
               return (obj is Array ? obj[index] : obj) as FlowElement;
          }
          
          override public function deepCopy(startPos:int = 0, endPos:int = -1) : flashx.textLayout.elements.FlowElement
          {
               var newFlowElement:flashx.textLayout.elements.FlowElement = null;
               var child:flashx.textLayout.elements.FlowElement = null;
               var possiblyEmptyFlowElement:flashx.textLayout.elements.FlowElement = null;
               if(endPos == -1)
               {
                    endPos = textLength;
               }
               var retFlow:FlowGroupElement = shallowCopy(startPos,endPos) as FlowGroupElement;
               for(var idx:int = 0; idx < this._numChildren; idx++)
               {
                    child = this.getChildAt(idx);
                    if(startPos - child.parentRelativeStart < child.textLength && endPos - child.parentRelativeStart > 0)
                    {
                         newFlowElement = child.deepCopy(startPos - child.parentRelativeStart,endPos - child.parentRelativeStart);
                         retFlow.replaceChildren(retFlow.numChildren,retFlow.numChildren,newFlowElement);
                         if(retFlow.numChildren > 1)
                         {
                              possiblyEmptyFlowElement = retFlow.getChildAt(retFlow.numChildren - 2);
                              if(possiblyEmptyFlowElement.textLength == 0)
                              {
                                   retFlow.replaceChildren(retFlow.numChildren - 2,retFlow.numChildren - 1);
                              }
                         }
                    }
               }
               return retFlow;
          }
          
          override public function getText(relativeStart:int = 0, relativeEnd:int = -1, paragraphSeparator:String = "\n") : String
          {
               var child:flashx.textLayout.elements.FlowElement = null;
               var copyStart:int = 0;
               var copyEnd:int = 0;
               var text:String = super.getText();
               if(relativeEnd == -1)
               {
                    relativeEnd = textLength;
               }
               var pos:int = relativeStart;
               var idx:int = this.findChildIndexAtPosition(relativeStart);
               while(idx < this._numChildren && pos < relativeEnd)
               {
                    child = this.getChildAt(idx);
                    copyStart = pos - child.parentRelativeStart;
                    copyEnd = Math.min(relativeEnd - child.parentRelativeStart,child.textLength);
                    text += child.getText(copyStart,copyEnd,paragraphSeparator);
                    pos += copyEnd - copyStart;
                    if(paragraphSeparator && child is ParagraphFormattedElement && pos < relativeEnd)
                    {
                         text += paragraphSeparator;
                    }
                    idx++;
               }
               return text;
          }
          
          override tlf_internal function formatChanged(notifyModelChanged:Boolean = true) : void
          {
               var child:flashx.textLayout.elements.FlowElement = null;
               super.tlf_internal::formatChanged(notifyModelChanged);
               for(var idx:int = 0; idx < this._numChildren; idx++)
               {
                    child = this.getChildAt(idx);
                    child.tlf_internal::formatChanged(false);
               }
          }
          
          override tlf_internal function styleSelectorChanged() : void
          {
               super.tlf_internal::styleSelectorChanged();
               this.tlf_internal::formatChanged(false);
          }
          
          [RichTextContent]
          public function get mxmlChildren() : Array
          {
               return this._numChildren == 0 ? null : (this._numChildren == 1 ? [this._singleChild] : this._childArray.slice());
          }
          
          public function set mxmlChildren(array:Array) : void
          {
               var child:Object = null;
               var s:SpanElement = null;
               this.replaceChildren(0,this._numChildren);
               var effectiveParent:FlowGroupElement = this;
               for each(child in array)
               {
                    if(child is FlowElement)
                    {
                         if(child is ParagraphFormattedElement)
                         {
                              effectiveParent = this;
                         }
                         else if(effectiveParent is ContainerFormattedElement)
                         {
                              effectiveParent = new ParagraphElement();
                              effectiveParent.tlf_internal::impliedElement = true;
                              this.replaceChildren(this._numChildren,this._numChildren,effectiveParent);
                         }
                         if(child is SpanElement || child is SubParagraphGroupElementBase)
                         {
                              child.bindableElement = true;
                         }
                         effectiveParent.replaceChildren(effectiveParent.numChildren,effectiveParent.numChildren,FlowElement(child));
                    }
                    else if(child is String)
                    {
                         s = new SpanElement();
                         s.text = String(child);
                         s.tlf_internal::bindableElement = true;
                         s.tlf_internal::impliedElement = true;
                         if(effectiveParent is ContainerFormattedElement)
                         {
                              effectiveParent = new ParagraphElement();
                              this.replaceChildren(this._numChildren,this._numChildren,effectiveParent);
                              effectiveParent.tlf_internal::impliedElement = true;
                         }
                         effectiveParent.replaceChildren(effectiveParent.numChildren,effectiveParent.numChildren,s);
                    }
                    else if(child != null)
                    {
                         throw new TypeError(GlobalSettings.resourceStringFunction("badMXMLChildrenArgument",[getQualifiedClassName(child)]));
                    }
               }
          }
          
          public function get numChildren() : int
          {
               return this._numChildren;
          }
          
          public function getChildIndex(child:flashx.textLayout.elements.FlowElement) : int
          {
               var mid:int = 0;
               var p:flashx.textLayout.elements.FlowElement = null;
               var testmid:int = 0;
               var hi:int = this._numChildren - 1;
               if(hi <= 0)
               {
                    return this._singleChild == child ? 0 : -1;
               }
               var lo:int = 0;
               while(lo <= hi)
               {
                    mid = (lo + hi) / 2;
                    p = this._childArray[mid];
                    if(p.parentRelativeStart == child.parentRelativeStart)
                    {
                         if(p == child)
                         {
                              return mid;
                         }
                         if(p.textLength == 0)
                         {
                              for(testmid = mid; testmid < this._numChildren; testmid++)
                              {
                                   p = this._childArray[testmid];
                                   if(p == child)
                                   {
                                        return testmid;
                                   }
                                   if(p.textLength != 0)
                                   {
                                        break;
                                   }
                              }
                         }
                         while(mid > 0)
                         {
                              mid--;
                              p = this._childArray[mid];
                              if(p == child)
                              {
                                   return mid;
                              }
                              if(p.textLength != 0)
                              {
                                   break;
                              }
                         }
                         return -1;
                    }
                    if(p.parentRelativeStart < child.parentRelativeStart)
                    {
                         lo = mid + 1;
                    }
                    else
                    {
                         hi = mid - 1;
                    }
               }
               return -1;
          }
          
          public function getChildAt(index:int) : flashx.textLayout.elements.FlowElement
          {
               if(this._numChildren > 1)
               {
                    return this._childArray[index];
               }
               return index == 0 ? this._singleChild : null;
          }
          
          tlf_internal function getNextLeafHelper(limitElement:FlowGroupElement, child:flashx.textLayout.elements.FlowElement) : FlowLeafElement
          {
               var idx:int = this.getChildIndex(child);
               if(idx == -1)
               {
                    return null;
               }
               if(idx == this._numChildren - 1)
               {
                    if(limitElement == this || !parent)
                    {
                         return null;
                    }
                    return parent.tlf_internal::getNextLeafHelper(limitElement,this);
               }
               child = this.getChildAt(idx + 1);
               return child is FlowLeafElement ? FlowLeafElement(child) : FlowGroupElement(child).getFirstLeaf();
          }
          
          tlf_internal function getPreviousLeafHelper(limitElement:FlowGroupElement, child:flashx.textLayout.elements.FlowElement) : FlowLeafElement
          {
               var idx:int = this.getChildIndex(child);
               if(idx == -1)
               {
                    return null;
               }
               if(idx == 0)
               {
                    if(limitElement == this || !parent)
                    {
                         return null;
                    }
                    return parent.tlf_internal::getPreviousLeafHelper(limitElement,this);
               }
               child = this.getChildAt(idx - 1);
               return child is FlowLeafElement ? FlowLeafElement(child) : FlowGroupElement(child).getLastLeaf();
          }
          
          public function findLeaf(relativePosition:int) : FlowLeafElement
          {
               var child:flashx.textLayout.elements.FlowElement = null;
               var childRelativePos:int = 0;
               var found:FlowLeafElement = null;
               var childIdx:int = this.findChildIndexAtPosition(relativePosition);
               if(childIdx != -1)
               {
                    do
                    {
                         child = this.getChildAt(childIdx++);
                         if(!child)
                         {
                              break;
                         }
                         childRelativePos = relativePosition - child.parentRelativeStart;
                         if(child is FlowGroupElement)
                         {
                              found = FlowGroupElement(child).findLeaf(childRelativePos);
                         }
                         else if(childRelativePos >= 0 && childRelativePos < child.textLength || child.textLength == 0 && this._numChildren == 1)
                         {
                              found = FlowLeafElement(child);
                         }
                    }
                    while(!found && !child.textLength);
                    
               }
               return found;
          }
          
          public function findChildIndexAtPosition(relativePosition:int) : int
          {
               var mid:int = 0;
               var child:flashx.textLayout.elements.FlowElement = null;
               var lo:int = 0;
               var hi:int = this._numChildren - 1;
               while(lo <= hi)
               {
                    mid = (lo + hi) / 2;
                    child = this.getChildAt(mid);
                    if(child.parentRelativeStart <= relativePosition)
                    {
                         if(child.parentRelativeStart == relativePosition)
                         {
                              while(mid != 0)
                              {
                                   child = this.getChildAt(mid - 1);
                                   if(child.textLength != 0)
                                   {
                                        break;
                                   }
                                   mid--;
                              }
                              return mid;
                         }
                         if(child.parentRelativeStart + child.textLength > relativePosition)
                         {
                              return mid;
                         }
                         lo = mid + 1;
                    }
                    else
                    {
                         hi = mid - 1;
                    }
               }
               return -1;
          }
          
          public function getFirstLeaf() : FlowLeafElement
          {
               var idx:int = 0;
               var child:flashx.textLayout.elements.FlowElement = null;
               var leaf:FlowLeafElement = null;
               if(this._numChildren > 1)
               {
                    for(idx = 0; idx < this._numChildren; idx++)
                    {
                         child = this._childArray[idx];
                         leaf = child is FlowGroupElement ? FlowGroupElement(child).getFirstLeaf() : FlowLeafElement(child);
                         if(Boolean(leaf))
                         {
                              return leaf;
                         }
                    }
                    return null;
               }
               return this._numChildren == 0 ? null : (this._singleChild is FlowGroupElement ? FlowGroupElement(this._singleChild).getFirstLeaf() : FlowLeafElement(this._singleChild));
          }
          
          public function getLastLeaf() : FlowLeafElement
          {
               var idx:int = 0;
               var child:flashx.textLayout.elements.FlowElement = null;
               var leaf:FlowLeafElement = null;
               if(this._numChildren > 1)
               {
                    for(idx = this._numChildren; idx != 0; idx--)
                    {
                         child = this._childArray[idx - 1];
                         leaf = child is FlowGroupElement ? FlowGroupElement(child).getLastLeaf() : FlowLeafElement(child);
                         if(Boolean(leaf))
                         {
                              return leaf;
                         }
                    }
                    return null;
               }
               return this._numChildren == 0 ? null : (this._singleChild is FlowGroupElement ? FlowGroupElement(this._singleChild).getLastLeaf() : FlowLeafElement(this._singleChild));
          }
          
          override public function getCharAtPosition(relativePosition:int) : String
          {
               var leaf:FlowLeafElement = this.findLeaf(relativePosition);
               return Boolean(leaf) ? leaf.getCharAtPosition(relativePosition - leaf.getElementRelativeStart(this)) : "";
          }
          
          override tlf_internal function applyFunctionToElements(func:Function) : Boolean
          {
               if(func(this))
               {
                    return true;
               }
               for(var idx:int = 0; idx < this._numChildren; idx++)
               {
                    if(this.getChildAt(idx).tlf_internal::applyFunctionToElements(func))
                    {
                         return true;
                    }
               }
               return false;
          }
          
          tlf_internal function removeBlockElement(child:flashx.textLayout.elements.FlowElement, block:ContentElement) : void
          {
          }
          
          tlf_internal function insertBlockElement(child:flashx.textLayout.elements.FlowElement, block:ContentElement) : void
          {
          }
          
          tlf_internal function hasBlockElement() : Boolean
          {
               return false;
          }
          
          tlf_internal function createContentAsGroup() : GroupElement
          {
               return null;
          }
          
          tlf_internal function addChildAfterInternal(child:flashx.textLayout.elements.FlowElement, newChild:flashx.textLayout.elements.FlowElement) : void
          {
               if(this._numChildren > 1)
               {
                    this._childArray.splice(this._childArray.indexOf(child) + 1,0,newChild);
               }
               else
               {
                    this._childArray = [this._singleChild,newChild];
                    this._singleChild = null;
               }
               ++this._numChildren;
               newChild.tlf_internal::setParentAndRelativeStartOnly(this,child.parentRelativeEnd);
          }
          
          tlf_internal function canOwnFlowElement(elem:flashx.textLayout.elements.FlowElement) : Boolean
          {
               return !(elem is TextFlow) && !(elem is FlowLeafElement) && !(elem is SubParagraphGroupElementBase) && !(elem is ListItemElement);
          }
          
          public function replaceChildren(beginChildIndex:int, endChildIndex:int, ... rest) : void
          {
               var flatNewChildList:Array = null;
               var newChildToAdd:flashx.textLayout.elements.FlowElement = null;
               var newChild:flashx.textLayout.elements.FlowElement = null;
               var idx:int = 0;
               var obj:Object = null;
               var child:flashx.textLayout.elements.FlowElement = null;
               var len:int = 0;
               var numNestedArgs:int = 0;
               var newChildParent:FlowGroupElement = null;
               var childIndex:int = 0;
               var addedTextLength:uint = 0;
               var enclosingContainer:ContainerController = null;
               var tFlow:TextFlow = null;
               if(beginChildIndex > this._numChildren || endChildIndex > this._numChildren)
               {
                    throw RangeError(GlobalSettings.resourceStringFunction("badReplaceChildrenIndex"));
               }
               var thisAbsStart:int = getAbsoluteStart();
               var absStartIdx:int = thisAbsStart + (beginChildIndex == this._numChildren ? textLength : this.getChildAt(beginChildIndex).parentRelativeStart);
               var relStartIdx:int = beginChildIndex == this._numChildren ? textLength : this.getChildAt(beginChildIndex).parentRelativeStart;
               if(beginChildIndex < endChildIndex)
               {
                    len = 0;
                    while(beginChildIndex < endChildIndex)
                    {
                         child = this.getChildAt(beginChildIndex);
                         this.tlf_internal::modelChanged(ModelChange.ELEMENT_REMOVAL,child,child.parentRelativeStart,child.textLength);
                         len += child.textLength;
                         child.tlf_internal::setParentAndRelativeStart(null,0);
                         if(this._numChildren == 1)
                         {
                              this._singleChild = null;
                              this._numChildren = 0;
                         }
                         else
                         {
                              this._childArray.splice(beginChildIndex,1);
                              --this._numChildren;
                              if(this._numChildren == 1)
                              {
                                   this._singleChild = this._childArray[0];
                                   this._childArray = null;
                              }
                         }
                         endChildIndex--;
                    }
                    if(Boolean(len))
                    {
                         while(endChildIndex < this._numChildren)
                         {
                              child = this.getChildAt(endChildIndex);
                              child.tlf_internal::setParentRelativeStart(child.parentRelativeStart - len);
                              endChildIndex++;
                         }
                         tlf_internal::updateLengths(absStartIdx,-len,true);
                         tlf_internal::deleteContainerText(relStartIdx + len,len);
                    }
               }
               var childrenToAdd:int = 0;
               for each(obj in rest)
               {
                    if(obj)
                    {
                         numNestedArgs = int(getNestedArgCount(obj));
                         for(idx = 0; idx < numNestedArgs; idx++)
                         {
                              newChild = getNestedArg(obj,idx);
                              if(Boolean(newChild))
                              {
                                   newChildParent = newChild.parent;
                                   if(Boolean(newChildParent))
                                   {
                                        if(newChildParent == this)
                                        {
                                             childIndex = this.getChildIndex(newChild);
                                             newChildParent.removeChild(newChild);
                                             thisAbsStart = getAbsoluteStart();
                                             if(childIndex <= beginChildIndex)
                                             {
                                                  beginChildIndex--;
                                                  absStartIdx = thisAbsStart + (beginChildIndex == this._numChildren ? textLength : this.getChildAt(beginChildIndex).parentRelativeStart);
                                                  relStartIdx = beginChildIndex == this._numChildren ? textLength : this.getChildAt(beginChildIndex).parentRelativeStart;
                                             }
                                        }
                                        else
                                        {
                                             newChildParent.removeChild(newChild);
                                             thisAbsStart = getAbsoluteStart();
                                             absStartIdx = thisAbsStart + (beginChildIndex == this._numChildren ? textLength : this.getChildAt(beginChildIndex).parentRelativeStart);
                                             relStartIdx = beginChildIndex == this._numChildren ? textLength : this.getChildAt(beginChildIndex).parentRelativeStart;
                                        }
                                   }
                                   if(!this.tlf_internal::canOwnFlowElement(newChild))
                                   {
                                        throw ArgumentError(GlobalSettings.resourceStringFunction("invalidChildType"));
                                   }
                                   if(childrenToAdd == 0)
                                   {
                                        newChildToAdd = newChild;
                                   }
                                   else if(childrenToAdd == 1)
                                   {
                                        flatNewChildList = [newChildToAdd,newChild];
                                   }
                                   else
                                   {
                                        flatNewChildList.push(newChild);
                                   }
                                   childrenToAdd++;
                              }
                         }
                    }
               }
               if(Boolean(childrenToAdd))
               {
                    addedTextLength = 0;
                    for(idx = 0; idx < childrenToAdd; idx++)
                    {
                         newChild = childrenToAdd == 1 ? newChildToAdd : flatNewChildList[idx];
                         if(this._numChildren == 0)
                         {
                              this._singleChild = newChild;
                         }
                         else if(this._numChildren > 1)
                         {
                              this._childArray.splice(beginChildIndex,0,newChild);
                         }
                         else
                         {
                              this._childArray = beginChildIndex == 0 ? [newChild,this._singleChild] : [this._singleChild,newChild];
                              this._singleChild = null;
                         }
                         ++this._numChildren;
                         newChild.tlf_internal::setParentAndRelativeStart(this,relStartIdx + addedTextLength);
                         addedTextLength += newChild.textLength;
                         beginChildIndex++;
                    }
                    if(Boolean(addedTextLength))
                    {
                         while(beginChildIndex < this._numChildren)
                         {
                              child = this.getChildAt(beginChildIndex++);
                              child.tlf_internal::setParentRelativeStart(child.parentRelativeStart + addedTextLength);
                         }
                         tlf_internal::updateLengths(absStartIdx,addedTextLength,true);
                         enclosingContainer = tlf_internal::getEnclosingController(relStartIdx);
                         if(Boolean(enclosingContainer))
                         {
                              ContainerController(enclosingContainer).tlf_internal::setTextLength(enclosingContainer.textLength + addedTextLength);
                         }
                    }
                    for(idx = 0; idx < childrenToAdd; idx++)
                    {
                         newChild = childrenToAdd == 1 ? newChildToAdd : flatNewChildList[idx];
                         this.tlf_internal::modelChanged(ModelChange.ELEMENT_ADDED,newChild,newChild.parentRelativeStart,newChild.textLength);
                    }
               }
               else
               {
                    tFlow = getTextFlow();
                    if(tFlow != null)
                    {
                         if(beginChildIndex < this._numChildren)
                         {
                              idx = thisAbsStart + this.getChildAt(beginChildIndex).parentRelativeStart;
                         }
                         else if(beginChildIndex > 1)
                         {
                              newChild = this.getChildAt(beginChildIndex - 1);
                              idx = thisAbsStart + newChild.parentRelativeStart + newChild.textLength - 1;
                         }
                         else
                         {
                              idx = thisAbsStart;
                              if(idx >= tFlow.textLength)
                              {
                                   idx--;
                              }
                         }
                         tFlow.tlf_internal::damage(idx,1,FlowDamageType.INVALID,false);
                    }
               }
          }
          
          public function addChild(child:flashx.textLayout.elements.FlowElement) : flashx.textLayout.elements.FlowElement
          {
               this.replaceChildren(this._numChildren,this._numChildren,child);
               return child;
          }
          
          public function addChildAt(index:uint, child:flashx.textLayout.elements.FlowElement) : flashx.textLayout.elements.FlowElement
          {
               this.replaceChildren(index,index,child);
               return child;
          }
          
          public function removeChild(child:flashx.textLayout.elements.FlowElement) : flashx.textLayout.elements.FlowElement
          {
               var index:int = this.getChildIndex(child);
               if(index == -1)
               {
                    throw ArgumentError(GlobalSettings.resourceStringFunction("badRemoveChild"));
               }
               this.removeChildAt(index);
               return child;
          }
          
          public function removeChildAt(index:uint) : flashx.textLayout.elements.FlowElement
          {
               var childToReplace:flashx.textLayout.elements.FlowElement = this.getChildAt(index);
               this.replaceChildren(index,index + 1);
               return childToReplace;
          }
          
          public function splitAtIndex(childIndex:int) : FlowGroupElement
          {
               var childArray:Array = null;
               var myidx:int = 0;
               if(childIndex > this._numChildren)
               {
                    throw RangeError(GlobalSettings.resourceStringFunction("invalidSplitAtIndex"));
               }
               var newSibling:FlowGroupElement = shallowCopy() as FlowGroupElement;
               var numChildrenToMove:int = this._numChildren - childIndex;
               if(numChildrenToMove == 1)
               {
                    newSibling.addChild(this.removeChildAt(childIndex));
               }
               else if(numChildrenToMove != 0)
               {
                    childArray = this._childArray.slice(childIndex);
                    this.replaceChildren(childIndex,this._numChildren - 1);
                    newSibling.replaceChildren(0,0,childArray);
               }
               if(Boolean(parent))
               {
                    myidx = parent.getChildIndex(this);
                    parent.replaceChildren(myidx + 1,myidx + 1,newSibling);
               }
               return newSibling;
          }
          
          override public function splitAtPosition(relativePosition:int) : flashx.textLayout.elements.FlowElement
          {
               var curElementIdx:int = 0;
               var curFlowElement:flashx.textLayout.elements.FlowElement = null;
               if(relativePosition < 0 || relativePosition > textLength)
               {
                    throw RangeError(GlobalSettings.resourceStringFunction("invalidSplitAtPosition"));
               }
               if(relativePosition == textLength)
               {
                    curElementIdx = this._numChildren;
               }
               else
               {
                    curElementIdx = this.findChildIndexAtPosition(relativePosition);
                    curFlowElement = this.getChildAt(curElementIdx);
                    if(curFlowElement.parentRelativeStart != relativePosition)
                    {
                         if(curFlowElement is FlowGroupElement)
                         {
                              FlowGroupElement(curFlowElement).splitAtPosition(relativePosition - curFlowElement.parentRelativeStart);
                         }
                         else
                         {
                              SpanElement(curFlowElement).splitAtPosition(relativePosition - curFlowElement.parentRelativeStart);
                         }
                         curElementIdx++;
                    }
               }
               return this.splitAtIndex(curElementIdx);
          }
          
          override tlf_internal function normalizeRange(normalizeStart:uint, normalizeEnd:uint) : void
          {
               var child:flashx.textLayout.elements.FlowElement = null;
               var origChildEnd:int = 0;
               var newChildEnd:int = 0;
               var idx:int = this.findChildIndexAtPosition(normalizeStart);
               if(idx != -1 && idx < this._numChildren)
               {
                    child = this.getChildAt(idx);
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
                         else
                         {
                              idx++;
                         }
                         if(idx == this._numChildren)
                         {
                              break;
                         }
                         child = this.getChildAt(idx);
                         if(child.parentRelativeStart > normalizeEnd)
                         {
                              break;
                         }
                         normalizeStart = 0;
                    }
               }
          }
          
          override tlf_internal function applyWhiteSpaceCollapse(collapse:String) : void
          {
               var ffc:ITextLayoutFormat = null;
               var wsc:* = undefined;
               var child:flashx.textLayout.elements.FlowElement = null;
               if(collapse == null)
               {
                    collapse = String(this.computedFormat.whiteSpaceCollapse);
               }
               else
               {
                    ffc = this.tlf_internal::formatForCascade;
                    wsc = Boolean(ffc) ? ffc.whiteSpaceCollapse : undefined;
                    if(wsc !== undefined && wsc != FormatValue.INHERIT)
                    {
                         collapse = wsc;
                    }
               }
               for(var idx:int = 0; idx < this._numChildren; )
               {
                    child = this.getChildAt(idx);
                    child.tlf_internal::applyWhiteSpaceCollapse(collapse);
                    if(child.parent == this)
                    {
                         idx++;
                    }
               }
               if(textLength == 0 && Boolean(tlf_internal::impliedElement) && parent != null)
               {
                    parent.removeChild(this);
               }
               super.tlf_internal::applyWhiteSpaceCollapse(collapse);
          }
          
          override tlf_internal function appendElementsForDelayedUpdate(tf:TextFlow, changeType:String) : void
          {
               var child:flashx.textLayout.elements.FlowElement = null;
               for(var idx:int = 0; idx < this._numChildren; idx++)
               {
                    child = this.getChildAt(idx);
                    child.tlf_internal::appendElementsForDelayedUpdate(tf,changeType);
               }
          }
     }
}
