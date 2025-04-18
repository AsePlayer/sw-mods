package fl.text
{
     import fl.timeline.TimelineManager;
     import fl.timeline.timelineManager.InstanceInfo;
     import flash.display.Bitmap;
     import flash.display.BitmapData;
     import flash.display.DisplayObject;
     import flash.events.Event;
     import flash.text.AntiAliasType;
     import flash.text.engine.FontLookup;
     import flash.text.engine.RenderingMode;
     import flash.utils.getDefinitionByName;
     import flashx.textLayout.conversion.TextConverter;
     import flashx.textLayout.edit.EditingMode;
     import flashx.textLayout.edit.SelectionFormat;
     import flashx.textLayout.elements.Configuration;
     import flashx.textLayout.elements.FlowLeafElement;
     import flashx.textLayout.elements.GlobalSettings;
     import flashx.textLayout.elements.IConfiguration;
     import flashx.textLayout.elements.InlineGraphicElement;
     import flashx.textLayout.elements.LinkElement;
     import flashx.textLayout.elements.ParagraphElement;
     import flashx.textLayout.elements.TCYElement;
     import flashx.textLayout.elements.TextFlow;
     import flashx.textLayout.formats.BackgroundColor;
     import flashx.textLayout.formats.Direction;
     import flashx.textLayout.formats.ITextLayoutFormat;
     import flashx.textLayout.formats.TextLayoutFormat;
     import flashx.textLayout.tlf_internal;
     
     [ExcludeClass]
     public class TCMRuntimeManager extends TimelineManager
     {
          
          private static var singleton:fl.text.TCMRuntimeManager = new fl.text.TCMRuntimeManager();
          
          private static var globalConfig:Object;
           
          
          public function TCMRuntimeManager()
          {
               super();
               _supportNextPrevAcrossFrames = true;
          }
          
          public static function checkTLFFontsLoaded(e:Event, fontName:String = null, fn:Function = null) : Boolean
          {
               var loaded:Boolean;
               var fontClass:Class = null;
               if(fontName == null && e != null)
               {
                    try
                    {
                         if(e.target.hasOwnProperty("__checkFontName_"))
                         {
                              fontName = String(e.target["__checkFontName_"]);
                         }
                    }
                    catch(te1:TypeError)
                    {
                         fontName = null;
                    }
               }
               if(fontName == null)
               {
                    if(e != null)
                    {
                         e.target.removeEventListener(Event.FRAME_CONSTRUCTED,checkTLFFontsLoaded,false);
                    }
                    return false;
               }
               loaded = true;
               try
               {
                    fontClass = Class(getDefinitionByName(fontName));
                    if(new fontClass()["fontName"] == null)
                    {
                         loaded = false;
                    }
               }
               catch(re:ReferenceError)
               {
                    loaded = false;
               }
               catch(te2:TypeError)
               {
                    loaded = false;
               }
               if(loaded)
               {
                    if(fn != null)
                    {
                         fn();
                    }
                    else if(e != null)
                    {
                         e.target.removeEventListener(Event.FRAME_CONSTRUCTED,checkTLFFontsLoaded,false);
                         if(e.target.hasOwnProperty("__registerTLFFonts"))
                         {
                              try
                              {
                                   e.target["__registerTLFFonts"]();
                              }
                              catch(te3:TypeError)
                              {
                              }
                         }
                    }
               }
               return loaded;
          }
          
          tlf_internal static function getGlobalConfig() : Object
          {
               if(globalConfig != null)
               {
                    return globalConfig;
               }
               globalConfig = new Configuration(true);
               globalConfig.inlineGraphicResolverFunction = TCMRuntimeManager.resolveInlines;
               globalConfig.focusedSelectionFormat = new SelectionFormat(12047870,1,"normal",0,1,"normal",500);
               globalConfig.inactiveSelectionFormat = new SelectionFormat(12047870,0,"normal",0,0,"normal",0);
               globalConfig.unfocusedSelectionFormat = new SelectionFormat(12047870,0,"normal",0,0,"normal",0);
               return globalConfig;
          }
          
          public static function getSingleton() : fl.text.TCMRuntimeManager
          {
               return singleton;
          }
          
          public static function ColorStringToUint(inColorString:String) : uint
          {
               if(inColorString.substr(0,1) == "#")
               {
                    inColorString = "0x" + inColorString.substr(1);
               }
               return uint(inColorString);
          }
          
          private static function resolveInlines(incomingILG:Object) : DisplayObject
          {
               var customSource:Object = null;
               var inlineInfo:* = undefined;
               var tf:TextFlow = null;
               var cls:Class = null;
               var bm:Bitmap = null;
               var ilg:InlineGraphicElement = incomingILG as InlineGraphicElement;
               if(ilg == null)
               {
                    return null;
               }
               var customFormats:Object = ilg.userStyles;
               var sdo:* = null;
               if(customFormats != null)
               {
                    customSource = customFormats["customSource"];
                    inlineInfo = customFormats["extraInfo"];
                    tf = ilg.getTextFlow();
                    if(inlineInfo != undefined)
                    {
                         cls = inlineInfo[customSource];
                         sdo = new cls();
                         if(sdo is BitmapData)
                         {
                              bm = new Bitmap(sdo);
                              sdo = new DynamicSprite();
                              sdo.addChild(bm);
                         }
                    }
                    if(sdo)
                    {
                         sdo["ilg"] = ilg;
                    }
               }
               return sdo as DisplayObject;
          }
          
          public function configureInstance(drawSprite:TCMText, ii:InstanceInfo) : void
          {
               var firstFormat:ITextLayoutFormat;
               var xmlTree:XML;
               var editPolicy:String;
               var usingTextFlow:Boolean;
               var leaf:FlowLeafElement;
               var typeTextStr:String;
               var multipleFormats:Boolean;
               var hasAnchor:Boolean;
               var hasTCY:Boolean;
               var multipleParagraphs:Boolean;
               var p:ParagraphElement;
               var hasILG:Boolean;
               var curLeaf:FlowLeafElement;
               var textFlow:TextFlow = null;
               var attr:String = null;
               var styles:Object = null;
               var customSource:Object = null;
               var computedFormat:ITextLayoutFormat = null;
               var fmt:TextLayoutFormat = null;
               TLFRuntimeTabManager.InitTabHandler(drawSprite);
               xmlTree = ii.data;
               typeTextStr = xmlTree.@type;
               textFlow = TextConverter.importToFlow(ii.data,TextConverter.TEXT_LAYOUT_FORMAT,IConfiguration(tlf_internal::getGlobalConfig()));
               GlobalSettings.fontMapperFunction = RuntimeFontMapper.fontMapper;
               leaf = textFlow.getFirstLeaf();
               hasILG = false;
               while(Boolean(leaf))
               {
                    if(Boolean(leaf as InlineGraphicElement))
                    {
                         hasILG = true;
                         styles = leaf.userStyles;
                         customSource = styles["customSource"];
                         if(ii.extraInfo != undefined && ii.extraInfo[customSource] != null)
                         {
                              styles["extraInfo"] = ii.extraInfo;
                              leaf.userStyles = styles;
                         }
                    }
                    leaf = leaf.getNextLeaf();
               }
               hasTCY = false;
               hasAnchor = false;
               firstFormat = textFlow.getFirstLeaf().computedFormat;
               multipleFormats = textFlow.direction == undefined ? firstFormat.direction == Direction.RTL : textFlow.direction != firstFormat.direction;
               curLeaf = textFlow.getFirstLeaf();
               p = textFlow.getChildAt(0) as ParagraphElement;
               multipleParagraphs = p.getNextParagraph() != null;
               if(!multipleFormats && !multipleParagraphs)
               {
                    while(Boolean(curLeaf))
                    {
                         computedFormat = curLeaf.computedFormat;
                         multipleFormats = !TextLayoutFormat.isEqual(computedFormat,firstFormat) || computedFormat.backgroundColor != undefined && computedFormat.backgroundColor != BackgroundColor.TRANSPARENT;
                         hasTCY = curLeaf.getParentByType(TCYElement) as TCYElement != null;
                         hasAnchor = curLeaf.getParentByType(LinkElement) as LinkElement != null;
                         if(multipleFormats || hasTCY || hasAnchor || hasILG)
                         {
                              break;
                         }
                         curLeaf = curLeaf.getNextLeaf();
                    }
               }
               usingTextFlow = multipleFormats || multipleParagraphs || hasTCY || hasAnchor || hasILG;
               attr = xmlTree.@columnCount;
               if(attr != null && attr.length > 0)
               {
                    textFlow.columnCount = isNaN(Number(attr)) ? 1 : Number(attr);
               }
               attr = xmlTree.@columnGap;
               if(attr != null && attr.length > 0)
               {
                    textFlow.columnGap = isNaN(Number(attr)) ? 0 : Number(attr);
               }
               attr = xmlTree.@verticalAlign;
               if(attr != null && attr.length > 0)
               {
                    textFlow.verticalAlign = attr;
               }
               attr = xmlTree.@firstBaselineOffset;
               if(attr != null && attr.length > 0)
               {
                    try
                    {
                         textFlow.firstBaselineOffset = attr;
                    }
                    catch(e:Error)
                    {
                         textFlow.firstBaselineOffset = isNaN(Number(attr)) ? "auto" : Number(attr);
                    }
               }
               attr = xmlTree.@paddingLeft;
               if(attr != null && attr.length > 0)
               {
                    textFlow.paddingLeft = isNaN(Number(attr)) ? "auto" : Number(attr);
               }
               attr = xmlTree.@paddingTop;
               if(attr != null && attr.length > 0)
               {
                    textFlow.paddingTop = isNaN(Number(attr)) ? "auto" : Number(attr);
               }
               attr = xmlTree.@paddingRight;
               if(attr != null && attr.length > 0)
               {
                    textFlow.paddingRight = isNaN(Number(attr)) ? "auto" : Number(attr);
               }
               attr = xmlTree.@paddingBottom;
               if(attr != null && attr.length > 0)
               {
                    textFlow.paddingBottom = isNaN(Number(attr)) ? "auto" : Number(attr);
               }
               attr = xmlTree.@antiAliasType;
               if(attr != null && attr.length > 0)
               {
                    textFlow.renderingMode = attr == AntiAliasType.ADVANCED ? RenderingMode.CFF : RenderingMode.NORMAL;
               }
               attr = xmlTree.@embedFonts;
               if(attr != null && attr.length > 0)
               {
                    textFlow.fontLookup = attr.toLowerCase() == "true" ? FontLookup.EMBEDDED_CFF : FontLookup.DEVICE;
               }
               if(usingTextFlow)
               {
                    drawSprite.tcm.setTextFlow(textFlow);
                    if(hasILG)
                    {
                         drawSprite.tcm.beginInteraction();
                         drawSprite.tcm.endInteraction();
                    }
               }
               else
               {
                    drawSprite.tcm.setText(textFlow.getText());
                    fmt = TextLayoutFormat(textFlow.getFirstLeaf().computedFormat);
                    if(fmt.paddingTop == "auto" && !isNaN(textFlow.paddingTop))
                    {
                         fmt.paddingTop = textFlow.paddingTop;
                    }
                    if(fmt.paddingLeft == "auto" && !isNaN(textFlow.paddingLeft))
                    {
                         fmt.paddingLeft = textFlow.paddingLeft;
                    }
                    if(fmt.paddingRight == "auto" && !isNaN(textFlow.paddingRight))
                    {
                         fmt.paddingRight = textFlow.paddingRight;
                    }
                    if(fmt.paddingBottom == "auto" && !isNaN(textFlow.paddingBottom))
                    {
                         fmt.paddingBottom = textFlow.paddingBottom;
                    }
                    fmt.lineBreak = textFlow.lineBreak;
                    fmt.verticalAlign = textFlow.verticalAlign;
                    fmt.columnCount = textFlow.columnCount;
                    fmt.columnGap = textFlow.columnGap;
                    fmt.direction = textFlow.direction;
                    drawSprite.tcm.hostFormat = fmt;
               }
               editPolicy = xmlTree.@editPolicy;
               if(editPolicy == null || editPolicy.length == 0 || editPolicy == "selectable")
               {
                    editPolicy = EditingMode.READ_SELECT;
               }
               drawSprite.tcm.editingMode = editPolicy;
               if(typeTextStr == "Paragraph")
               {
                    drawSprite.tcm.compositionHeight = ii.bounds.height;
                    drawSprite.tcm.compositionWidth = ii.bounds.width;
               }
               else
               {
                    drawSprite.tcm.compositionHeight = drawSprite.tcm.compositionWidth = NaN;
               }
               attr = xmlTree.@background;
               if(attr != null && attr.length > 0)
               {
                    drawSprite.background = attr.toLowerCase() == "true";
               }
               attr = xmlTree.@backgroundColor;
               if(attr != null && attr.length > 0)
               {
                    drawSprite.backgroundColor = ColorStringToUint(attr);
               }
               attr = xmlTree.@backgroundAlpha;
               if(attr != null && attr.length > 0)
               {
                    drawSprite.backgroundAlpha = Number(attr);
               }
               attr = xmlTree.@border;
               if(attr != null && attr.length > 0)
               {
                    drawSprite.border = attr.toLowerCase() == "true";
               }
               attr = xmlTree.@borderColor;
               if(attr != null && attr.length > 0)
               {
                    drawSprite.borderColor = ColorStringToUint(attr);
               }
               attr = xmlTree.@borderAlpha;
               if(attr != null && attr.length > 0)
               {
                    drawSprite.borderAlpha = Number(attr);
               }
               attr = xmlTree.@borderWidth;
               if(attr != null && attr.length > 0)
               {
                    drawSprite.borderWidth = Number(attr);
               }
               drawSprite.tlf_internal::repaint(null);
          }
          
          override protected function getInstanceForInfo(ii:InstanceInfo, instance:DisplayObject = null) : DisplayObject
          {
               var drawSprite:TCMText;
               try
               {
                    if(getDefinitionByName("flashx.textLayout.container.TextContainerManager") == null || getDefinitionByName("fl.text.TLFTextContainerManager") == null)
                    {
                         return null;
                    }
               }
               catch(re:ReferenceError)
               {
                    return null;
               }
               drawSprite = instance == null ? new TCMText() : TCMText(instance);
               this.configureInstance(drawSprite,ii);
               return drawSprite;
          }
     }
}
