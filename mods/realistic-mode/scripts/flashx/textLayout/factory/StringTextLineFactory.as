package flashx.textLayout.factory
{
     import flash.geom.Rectangle;
     import flash.text.engine.TextLine;
     import flashx.textLayout.compose.FlowComposerBase;
     import flashx.textLayout.compose.SimpleCompose;
     import flashx.textLayout.container.ScrollPolicy;
     import flashx.textLayout.elements.Configuration;
     import flashx.textLayout.elements.IConfiguration;
     import flashx.textLayout.elements.ParagraphElement;
     import flashx.textLayout.elements.SpanElement;
     import flashx.textLayout.elements.TextFlow;
     import flashx.textLayout.formats.BlockProgression;
     import flashx.textLayout.formats.ITextLayoutFormat;
     import flashx.textLayout.formats.LineBreak;
     import flashx.textLayout.tlf_internal;
     
     public class StringTextLineFactory extends TextLineFactoryBase
     {
          
          private static var _defaultConfiguration:Configuration = null;
          
          private static var _measurementFactory:flashx.textLayout.factory.StringTextLineFactory = null;
          
          private static var _measurementLines:Array = null;
           
          
          private var _tf:TextFlow;
          
          private var _para:ParagraphElement;
          
          private var _span:SpanElement;
          
          private var _formatsChanged:Boolean;
          
          private var _configuration:IConfiguration;
          
          private var _truncatedText:String;
          
          public function StringTextLineFactory(configuration:IConfiguration = null)
          {
               super();
               this.initialize(configuration);
          }
          
          public static function get defaultConfiguration() : IConfiguration
          {
               if(!_defaultConfiguration)
               {
                    _defaultConfiguration = TextFlow.defaultConfiguration.clone();
                    _defaultConfiguration.flowComposerClass = tlf_internal::getDefaultFlowComposerClass();
                    _defaultConfiguration.textFlowInitialFormat = null;
               }
               return _defaultConfiguration;
          }
          
          private static function measurementFactory() : flashx.textLayout.factory.StringTextLineFactory
          {
               if(_measurementFactory == null)
               {
                    _measurementFactory = new flashx.textLayout.factory.StringTextLineFactory();
               }
               return _measurementFactory;
          }
          
          private static function measurementLines() : Array
          {
               if(_measurementLines == null)
               {
                    _measurementLines = new Array();
               }
               return _measurementLines;
          }
          
          private static function noopfunction(o:Object) : void
          {
          }
          
          public function get configuration() : IConfiguration
          {
               return this._configuration;
          }
          
          private function initialize(config:IConfiguration) : void
          {
               this._configuration = Configuration(Boolean(config) ? config : defaultConfiguration).tlf_internal::getImmutableClone();
               this._tf = new TextFlow(this._configuration);
               this._para = new ParagraphElement();
               this._span = new SpanElement();
               this._para.replaceChildren(0,0,this._span);
               this._tf.replaceChildren(0,0,this._para);
               this._tf.flowComposer.addController(containerController);
               this._formatsChanged = true;
          }
          
          public function get spanFormat() : ITextLayoutFormat
          {
               return this._span.format;
          }
          
          public function set spanFormat(format:ITextLayoutFormat) : void
          {
               this._span.format = format;
               this._formatsChanged = true;
          }
          
          public function get paragraphFormat() : ITextLayoutFormat
          {
               return this._para.format;
          }
          
          public function set paragraphFormat(format:ITextLayoutFormat) : void
          {
               this._para.format = format;
               this._formatsChanged = true;
          }
          
          public function get textFlowFormat() : ITextLayoutFormat
          {
               return this._tf.format;
          }
          
          public function set textFlowFormat(format:ITextLayoutFormat) : void
          {
               this._tf.format = format;
               this._formatsChanged = true;
          }
          
          public function get text() : String
          {
               return this._span.text;
          }
          
          public function set text(string:String) : void
          {
               this._span.text = string;
          }
          
          public function createTextLines(callback:Function) : void
          {
               var saved:SimpleCompose = TextLineFactoryBase.tlf_internal::beginFactoryCompose();
               try
               {
                    this.createTextLinesInternal(callback);
               }
               finally
               {
                    tlf_internal::_factoryComposer._lines.splice(0);
                    if(Boolean(_pass0Lines))
                    {
                         _pass0Lines.splice(0);
                    }
                    TextLineFactoryBase.tlf_internal::endFactoryCompose(saved);
               }
          }
          
          private function createTextLinesInternal(callback:Function) : void
          {
               var measureWidth:Boolean = !compositionBounds || isNaN(compositionBounds.width);
               var measureHeight:Boolean = !compositionBounds || isNaN(compositionBounds.height);
               var bp:String = String(this._tf.computedFormat.blockProgression);
               containerController.setCompositionSize(compositionBounds.width,compositionBounds.height);
               containerController.verticalScrollPolicy = Boolean(truncationOptions) ? ScrollPolicy.OFF : verticalScrollPolicy;
               containerController.horizontalScrollPolicy = Boolean(truncationOptions) ? ScrollPolicy.OFF : horizontalScrollPolicy;
               _isTruncated = false;
               this._truncatedText = this.text;
               if(!this._formatsChanged && FlowComposerBase.tlf_internal::computeBaseSWFContext(this._tf.flowComposer.swfContext) != FlowComposerBase.tlf_internal::computeBaseSWFContext(swfContext))
               {
                    this._formatsChanged = true;
               }
               this._tf.flowComposer.swfContext = swfContext;
               if(this._formatsChanged)
               {
                    this._tf.tlf_internal::normalize();
                    this._formatsChanged = false;
               }
               this._tf.flowComposer.compose();
               if(Boolean(truncationOptions))
               {
                    this.tlf_internal::doTruncation(bp,measureWidth,measureHeight);
               }
               var xadjust:Number = compositionBounds.x;
               var controllerBounds:Rectangle = containerController.getContentBounds();
               if(bp == BlockProgression.RL)
               {
                    xadjust += measureWidth ? controllerBounds.width : compositionBounds.width;
               }
               controllerBounds.left += xadjust;
               controllerBounds.right += xadjust;
               controllerBounds.top += compositionBounds.y;
               controllerBounds.bottom += compositionBounds.y;
               if(Boolean(this._tf.tlf_internal::backgroundManager))
               {
                    tlf_internal::processBackgroundColors(this._tf,callback,xadjust,compositionBounds.y,containerController.compositionWidth,containerController.compositionHeight);
               }
               callbackWithTextLines(callback,xadjust,compositionBounds.y);
               setContentBounds(controllerBounds);
               containerController.tlf_internal::clearCompositionResults();
          }
          
          tlf_internal function doTruncation(bp:String, measureWidth:Boolean, measureHeight:Boolean) : void
          {
               var somethingFit:Boolean = false;
               var originalText:String = null;
               var truncateAtCharPosition:int = 0;
               var line:TextLine = null;
               var targetWidth:Number = NaN;
               var allowedWidth:Number = NaN;
               var newTruncateAtCharPosition:int = 0;
               bp = String(this._tf.computedFormat.blockProgression);
               if(!doesComposedTextFit(truncationOptions.lineCountLimit,this._tf.textLength,bp))
               {
                    _isTruncated = true;
                    somethingFit = false;
                    originalText = this._span.text;
                    tlf_internal::computeLastAllowedLineIndex(truncationOptions.lineCountLimit);
                    if(_truncationLineIndex >= 0)
                    {
                         this.measureTruncationIndicator(compositionBounds,truncationOptions.truncationIndicator);
                         _truncationLineIndex -= _measurementLines.length - 1;
                         if(_truncationLineIndex >= 0)
                         {
                              if(this._tf.computedFormat.lineBreak == LineBreak.EXPLICIT || (bp == BlockProgression.TB ? measureWidth : measureHeight))
                              {
                                   line = tlf_internal::_factoryComposer._lines[_truncationLineIndex] as TextLine;
                                   truncateAtCharPosition = line.userData + line.rawTextLength;
                              }
                              else
                              {
                                   targetWidth = bp == BlockProgression.TB ? compositionBounds.width : compositionBounds.height;
                                   if(Boolean(this.paragraphFormat))
                                   {
                                        targetWidth -= Number(this.paragraphFormat.paragraphSpaceAfter) + Number(this.paragraphFormat.paragraphSpaceBefore);
                                        if(_truncationLineIndex == 0)
                                        {
                                             targetWidth -= this.paragraphFormat.textIndent;
                                        }
                                   }
                                   allowedWidth = targetWidth - (_measurementLines[_measurementLines.length - 1] as TextLine).unjustifiedTextWidth;
                                   truncateAtCharPosition = int(this.getTruncationPosition(tlf_internal::_factoryComposer._lines[_truncationLineIndex],allowedWidth));
                              }
                              if(!_pass0Lines)
                              {
                                   _pass0Lines = new Array();
                              }
                              _pass0Lines = tlf_internal::_factoryComposer.tlf_internal::swapLines(_pass0Lines);
                              this._para = this._para.deepCopy() as ParagraphElement;
                              this._span = this._para.getChildAt(0) as SpanElement;
                              this._tf.replaceChildren(0,1,this._para);
                              this._tf.tlf_internal::normalize();
                              this._span.replaceText(truncateAtCharPosition,this._span.textLength,truncationOptions.truncationIndicator);
                              do
                              {
                                   this._tf.flowComposer.compose();
                                   if(doesComposedTextFit(truncationOptions.lineCountLimit,this._tf.textLength,bp))
                                   {
                                        somethingFit = true;
                                        break;
                                   }
                                   if(truncateAtCharPosition == 0)
                                   {
                                        break;
                                   }
                                   newTruncateAtCharPosition = getNextTruncationPosition(truncateAtCharPosition);
                                   this._span.replaceText(newTruncateAtCharPosition,truncateAtCharPosition,null);
                                   truncateAtCharPosition = newTruncateAtCharPosition;
                              }
                              while(true);
                              
                         }
                         _measurementLines.splice(0);
                    }
                    if(somethingFit)
                    {
                         this._truncatedText = this._span.text;
                    }
                    else
                    {
                         this._truncatedText = "";
                         tlf_internal::_factoryComposer._lines.splice(0);
                    }
                    this._span.text = originalText;
               }
          }
          
          tlf_internal function get truncatedText() : String
          {
               return this._truncatedText;
          }
          
          private function measureTruncationIndicator(compositionBounds:Rectangle, truncationIndicator:String) : void
          {
               var originalLines:Array = tlf_internal::_factoryComposer.tlf_internal::swapLines(measurementLines());
               var measureFactory:flashx.textLayout.factory.StringTextLineFactory = measurementFactory();
               measureFactory.compositionBounds = compositionBounds;
               measureFactory.text = truncationIndicator;
               measureFactory.spanFormat = this.spanFormat;
               measureFactory.paragraphFormat = this.paragraphFormat;
               measureFactory.textFlowFormat = this.textFlowFormat;
               measureFactory.truncationOptions = null;
               measureFactory.createTextLinesInternal(noopfunction);
               tlf_internal::_factoryComposer.tlf_internal::swapLines(originalLines);
          }
          
          private function getTruncationPosition(line:TextLine, allowedWidth:Number) : uint
          {
               var atomIndex:int = 0;
               var atomBounds:Rectangle = null;
               var consumedWidth:Number = 0;
               var charPosition:int = line.userData;
               while(charPosition < line.userData + line.rawTextLength)
               {
                    atomIndex = line.getAtomIndexAtCharIndex(charPosition);
                    atomBounds = line.getAtomBounds(atomIndex);
                    consumedWidth += atomBounds.width;
                    if(consumedWidth > allowedWidth)
                    {
                         break;
                    }
                    charPosition = line.getAtomTextBlockEndIndex(atomIndex);
               }
               line.flushAtomData();
               return charPosition;
          }
     }
}
