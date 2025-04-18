package flashx.textLayout.compose
{
     import flash.display.Sprite;
     import flash.system.Capabilities;
     import flashx.textLayout.accessibility.TextAccImpl;
     import flashx.textLayout.container.ContainerController;
     import flashx.textLayout.container.ScrollPolicy;
     import flashx.textLayout.edit.ISelectionManager;
     import flashx.textLayout.elements.BackgroundManager;
     import flashx.textLayout.elements.ContainerFormattedElement;
     import flashx.textLayout.elements.TextFlow;
     import flashx.textLayout.events.CompositionCompleteEvent;
     import flashx.textLayout.formats.BlockProgression;
     import flashx.textLayout.tlf_internal;
     
     public class StandardFlowComposer extends FlowComposerBase implements IFlowComposer
     {
           
          
          tlf_internal var _rootElement:ContainerFormattedElement;
          
          private var _controllerList:Array;
          
          private var _composing:Boolean;
          
          private var lastBPDirectionScrollPosition:Number = -Infinity;
          
          public function StandardFlowComposer()
          {
               super();
               this._controllerList = new Array();
               this._composing = false;
          }
          
          private static function clearContainerAccessibilityImplementation(cont:Sprite) : void
          {
               if(Boolean(cont.accessibilityImplementation))
               {
                    if(cont.accessibilityImplementation is TextAccImpl)
                    {
                         TextAccImpl(cont.accessibilityImplementation).detachListeners();
                    }
                    cont.accessibilityImplementation = null;
               }
          }
          
          private static function getBPDirectionScrollPosition(bp:String, cont:ContainerController) : Number
          {
               return bp == BlockProgression.TB ? cont.verticalScrollPosition : cont.horizontalScrollPosition;
          }
          
          public function get composing() : Boolean
          {
               return this._composing;
          }
          
          public function getAbsoluteStart(controller:ContainerController) : int
          {
               var stopIdx:int = this.getControllerIndex(controller);
               var rslt:int = this.tlf_internal::_rootElement.getAbsoluteStart();
               for(var idx:int = 0; idx < stopIdx; idx++)
               {
                    rslt += this._controllerList[idx].textLength;
               }
               return rslt;
          }
          
          public function get rootElement() : ContainerFormattedElement
          {
               return this.tlf_internal::_rootElement;
          }
          
          public function setRootElement(newRootElement:ContainerFormattedElement) : void
          {
               if(this.tlf_internal::_rootElement != newRootElement)
               {
                    if(newRootElement is TextFlow && (newRootElement as TextFlow).flowComposer != this)
                    {
                         (newRootElement as TextFlow).flowComposer = this;
                    }
                    else
                    {
                         this.tlf_internal::clearCompositionResults();
                         this.tlf_internal::detachAllContainers();
                         this.tlf_internal::_rootElement = newRootElement;
                         _textFlow = Boolean(this.tlf_internal::_rootElement) ? this.tlf_internal::_rootElement.getTextFlow() : null;
                         this.tlf_internal::attachAllContainers();
                    }
               }
          }
          
          tlf_internal function detachAllContainers() : void
          {
               var cont:ContainerController = null;
               var firstContainerController:ContainerController = null;
               var firstContainer:Sprite = null;
               if(this._controllerList.length > 0 && Boolean(_textFlow))
               {
                    firstContainerController = this.getControllerAt(0);
                    firstContainer = firstContainerController.container;
                    if(Boolean(firstContainer))
                    {
                         clearContainerAccessibilityImplementation(firstContainer);
                    }
               }
               for each(cont in this._controllerList)
               {
                    cont.tlf_internal::clearSelectionShapes();
                    cont.tlf_internal::setRootElement(null);
               }
          }
          
          tlf_internal function attachAllContainers() : void
          {
               var cont:ContainerController = null;
               var curContainer:Sprite = null;
               var i:int = 0;
               var firstContainer:Sprite = null;
               for each(cont in this._controllerList)
               {
                    ContainerController(cont).tlf_internal::setRootElement(this.tlf_internal::_rootElement);
               }
               if(this._controllerList.length > 0 && Boolean(_textFlow))
               {
                    if(Boolean(textFlow.configuration.enableAccessibility) && Capabilities.hasAccessibility)
                    {
                         firstContainer = this.getControllerAt(0).container;
                         if(Boolean(firstContainer))
                         {
                              clearContainerAccessibilityImplementation(firstContainer);
                              firstContainer.accessibilityImplementation = new TextAccImpl(firstContainer,_textFlow);
                         }
                    }
                    for(i = 0; i < this._controllerList.length; i++)
                    {
                         curContainer = this.getControllerAt(i).container;
                         if(Boolean(curContainer))
                         {
                              curContainer.focusRect = false;
                         }
                    }
               }
               this.tlf_internal::clearCompositionResults();
          }
          
          public function get numControllers() : int
          {
               return Boolean(this._controllerList) ? int(this._controllerList.length) : 0;
          }
          
          public function addController(controller:ContainerController) : void
          {
               var curContainer:Sprite = null;
               var damageStart:int = 0;
               var damageLen:int = 0;
               this._controllerList.push(ContainerController(controller));
               if(this.numControllers == 1)
               {
                    this.tlf_internal::attachAllContainers();
               }
               else
               {
                    controller.tlf_internal::setRootElement(this.tlf_internal::_rootElement);
                    curContainer = controller.container;
                    if(Boolean(curContainer))
                    {
                         curContainer.focusRect = false;
                    }
                    if(Boolean(textFlow))
                    {
                         controller = this.getControllerAt(this.numControllers - 2);
                         damageStart = controller.absoluteStart;
                         damageLen = controller.textLength;
                         if(damageLen == 0)
                         {
                              if(damageStart != textFlow.textLength)
                              {
                                   damageLen++;
                              }
                              else if(damageStart != 0)
                              {
                                   damageStart--;
                                   damageLen++;
                              }
                         }
                         if(Boolean(damageLen))
                         {
                              textFlow.tlf_internal::damage(damageStart,damageLen,FlowDamageType.GEOMETRY,false);
                         }
                    }
               }
          }
          
          public function addControllerAt(controller:ContainerController, index:int) : void
          {
               this.tlf_internal::detachAllContainers();
               this._controllerList.splice(index,0,ContainerController(controller));
               this.tlf_internal::attachAllContainers();
          }
          
          private function fastRemoveController(index:int) : Boolean
          {
               var firstContainer:Sprite = null;
               if(index == -1)
               {
                    return true;
               }
               var cont:ContainerController = this._controllerList[index];
               if(!cont)
               {
                    return true;
               }
               if(!_textFlow || cont.absoluteStart == _textFlow.textLength)
               {
                    if(index == 0)
                    {
                         firstContainer = cont.container;
                         if(Boolean(firstContainer))
                         {
                              clearContainerAccessibilityImplementation(firstContainer);
                         }
                    }
                    cont.tlf_internal::setRootElement(null);
                    this._controllerList.splice(index,1);
                    return true;
               }
               return false;
          }
          
          public function removeController(controller:ContainerController) : void
          {
               var index:int = this.getControllerIndex(controller);
               if(!this.fastRemoveController(index))
               {
                    this.tlf_internal::detachAllContainers();
                    this._controllerList.splice(index,1);
                    this.tlf_internal::attachAllContainers();
               }
          }
          
          public function removeControllerAt(index:int) : void
          {
               if(!this.fastRemoveController(index))
               {
                    this.tlf_internal::detachAllContainers();
                    this._controllerList.splice(index,1);
                    this.tlf_internal::attachAllContainers();
               }
          }
          
          public function removeAllControllers() : void
          {
               this.tlf_internal::detachAllContainers();
               this._controllerList.splice(0,this._controllerList.length);
          }
          
          public function getControllerAt(index:int) : ContainerController
          {
               return this._controllerList[index];
          }
          
          public function getControllerIndex(controller:ContainerController) : int
          {
               for(var idx:int = 0; idx < this._controllerList.length; idx++)
               {
                    if(this._controllerList[idx] == controller)
                    {
                         return idx;
                    }
               }
               return -1;
          }
          
          public function findControllerIndexAtPosition(absolutePosition:int, preferPrevious:Boolean = false) : int
          {
               var mid:int = 0;
               var cont:ContainerController = null;
               var lo:int = 0;
               var hi:int = this._controllerList.length - 1;
               while(lo <= hi)
               {
                    mid = (lo + hi) / 2;
                    cont = this._controllerList[mid];
                    if(cont.absoluteStart <= absolutePosition)
                    {
                         if(preferPrevious)
                         {
                              if(cont.absoluteStart + cont.textLength >= absolutePosition)
                              {
                                   while(mid != 0 && cont.absoluteStart == absolutePosition)
                                   {
                                        mid--;
                                        cont = this._controllerList[mid];
                                   }
                                   return mid;
                              }
                         }
                         else
                         {
                              if(cont.absoluteStart == absolutePosition && cont.textLength != 0)
                              {
                                   while(mid != 0)
                                   {
                                        cont = this._controllerList[mid - 1];
                                        if(cont.textLength != 0)
                                        {
                                             break;
                                        }
                                        mid--;
                                   }
                                   return mid;
                              }
                              if(cont.absoluteStart + cont.textLength > absolutePosition)
                              {
                                   return mid;
                              }
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
          
          tlf_internal function clearCompositionResults() : void
          {
               var cont:ContainerController = null;
               initializeLines();
               for each(cont in this._controllerList)
               {
                    cont.tlf_internal::clearCompositionResults();
               }
          }
          
          public function updateAllControllers() : Boolean
          {
               return this.updateToController();
          }
          
          public function updateToController(index:int = 2147483647) : Boolean
          {
               if(this._composing)
               {
                    return false;
               }
               var sm:ISelectionManager = textFlow.interactionManager;
               if(Boolean(sm))
               {
                    sm.flushPendingOperations();
               }
               this.internalCompose(-1,index);
               var shapesDamaged:Boolean = this.tlf_internal::areShapesDamaged();
               if(shapesDamaged)
               {
                    this.updateCompositionShapes();
               }
               if(Boolean(sm))
               {
                    sm.refreshSelection();
               }
               return shapesDamaged;
          }
          
          public function setFocus(absolutePosition:int, leanLeft:Boolean = false) : void
          {
               var idx:int = this.findControllerIndexAtPosition(absolutePosition,leanLeft);
               if(idx == -1)
               {
                    idx = this.numControllers - 1;
               }
               if(idx != -1)
               {
                    this._controllerList[idx].setFocus();
               }
          }
          
          public function interactionManagerChanged(newInteractionManager:ISelectionManager) : void
          {
               var controller:ContainerController = null;
               for each(controller in this._controllerList)
               {
                    controller.tlf_internal::interactionManagerChanged(newInteractionManager);
               }
          }
          
          private function updateCompositionShapes() : void
          {
               var controller:ContainerController = null;
               for each(controller in this._controllerList)
               {
                    controller.tlf_internal::updateCompositionShapes();
               }
          }
          
          override public function isDamaged(absolutePosition:int) : Boolean
          {
               var container:ContainerController = null;
               if(!super.isDamaged(absolutePosition))
               {
                    if(absolutePosition == _textFlow.textLength)
                    {
                         container = this.getControllerAt(this.numControllers - 1);
                         if(Boolean(container) && (container.verticalScrollPolicy != ScrollPolicy.OFF || container.horizontalScrollPolicy != ScrollPolicy.OFF))
                         {
                              return true;
                         }
                    }
                    return false;
               }
               return true;
          }
          
          protected function preCompose() : Boolean
          {
               this.rootElement.tlf_internal::preCompose();
               if(numLines == 0)
               {
                    initializeLines();
               }
               return this.isDamaged(this.rootElement.getAbsoluteStart() + this.rootElement.textLength);
          }
          
          tlf_internal function getComposeState() : ComposeState
          {
               return ComposeState.tlf_internal::getComposeState();
          }
          
          tlf_internal function releaseComposeState(state:ComposeState) : void
          {
               ComposeState.tlf_internal::releaseComposeState(state);
          }
          
          tlf_internal function callTheComposer(composeToPosition:int, controllerEndIndex:int) : ContainerController
          {
               if(_damageAbsoluteStart == this.rootElement.getAbsoluteStart() + this.rootElement.textLength)
               {
                    return this.getControllerAt(this.numControllers - 1);
               }
               var state:ComposeState = this.tlf_internal::getComposeState();
               var lastComposedPosition:int = state.composeTextFlow(textFlow,composeToPosition,controllerEndIndex);
               if(_damageAbsoluteStart < lastComposedPosition)
               {
                    _damageAbsoluteStart = lastComposedPosition;
               }
               finalizeLinesAfterCompose();
               var startController:ContainerController = state.startController;
               this.tlf_internal::releaseComposeState(state);
               if(textFlow.hasEventListener(CompositionCompleteEvent.COMPOSITION_COMPLETE))
               {
                    textFlow.dispatchEvent(new CompositionCompleteEvent(CompositionCompleteEvent.COMPOSITION_COMPLETE,false,false,textFlow,0,lastComposedPosition));
               }
               return startController;
          }
          
          private function internalCompose(composeToPosition:int = -1, composeToControllerIndex:int = -1) : ContainerController
          {
               var bp:String = null;
               var startController:ContainerController = null;
               var damageLimit:int = 0;
               var controller:ContainerController = null;
               var lastVisibleLine:TextFlowLine = null;
               var idx:int = 0;
               var sm:ISelectionManager = textFlow.interactionManager;
               if(Boolean(sm))
               {
                    sm.flushPendingOperations();
               }
               this._composing = true;
               try
               {
                    if(this.preCompose())
                    {
                         if(Boolean(textFlow) && this.numControllers != 0)
                         {
                              damageLimit = _textFlow.textLength;
                              composeToControllerIndex = Math.min(composeToControllerIndex,this.numControllers - 1);
                              if(composeToPosition != -1 || composeToControllerIndex != -1)
                              {
                                   if(composeToControllerIndex < 0)
                                   {
                                        if(composeToPosition >= 0)
                                        {
                                             damageLimit = composeToPosition;
                                        }
                                   }
                                   else
                                   {
                                        controller = this.getControllerAt(composeToControllerIndex);
                                        if(controller.textLength != 0)
                                        {
                                             damageLimit = controller.absoluteStart + controller.textLength;
                                        }
                                        if(composeToControllerIndex == this.numControllers - 1)
                                        {
                                             bp = String(this.rootElement.computedFormat.blockProgression);
                                             lastVisibleLine = controller.tlf_internal::getLastVisibleLine();
                                             if(Boolean(lastVisibleLine) && getBPDirectionScrollPosition(bp,controller) == this.lastBPDirectionScrollPosition)
                                             {
                                                  damageLimit = lastVisibleLine.absoluteStart + lastVisibleLine.textLength;
                                             }
                                        }
                                   }
                              }
                              this.lastBPDirectionScrollPosition = Number.NEGATIVE_INFINITY;
                              if(_damageAbsoluteStart < damageLimit)
                              {
                                   startController = this.tlf_internal::callTheComposer(composeToPosition,composeToControllerIndex);
                                   if(Boolean(startController))
                                   {
                                        idx = this.getControllerIndex(startController);
                                        while(idx < this.numControllers)
                                        {
                                             this.getControllerAt(idx++).tlf_internal::shapesInvalid = true;
                                        }
                                   }
                              }
                         }
                    }
               }
               catch(e:Error)
               {
                    _composing = false;
                    throw e;
               }
               this._composing = false;
               if(composeToControllerIndex == this.numControllers - 1)
               {
                    this.lastBPDirectionScrollPosition = getBPDirectionScrollPosition(bp,controller);
               }
               return startController;
          }
          
          tlf_internal function areShapesDamaged() : Boolean
          {
               var cont:ContainerController = null;
               for each(cont in this._controllerList)
               {
                    if(cont.tlf_internal::shapesInvalid)
                    {
                         return true;
                    }
               }
               return false;
          }
          
          public function compose() : Boolean
          {
               return this._composing ? false : this.internalCompose() != null;
          }
          
          public function composeToPosition(absolutePosition:int = 2147483647) : Boolean
          {
               return this._composing ? false : this.internalCompose(absolutePosition,-1) != null;
          }
          
          public function composeToController(index:int = 2147483647) : Boolean
          {
               return this._composing ? false : this.internalCompose(-1,index) != null;
          }
          
          tlf_internal function createBackgroundManager() : BackgroundManager
          {
               return new BackgroundManager();
          }
     }
}
