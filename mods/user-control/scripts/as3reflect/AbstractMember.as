package as3reflect
{
     public class AbstractMember extends MetaDataContainer implements IMember
     {
           
          
          private var _declaringType:as3reflect.Type;
          
          private var _name:String;
          
          private var _isStatic:Boolean;
          
          private var _type:as3reflect.Type;
          
          public function AbstractMember(name:String, type:as3reflect.Type, declaringType:as3reflect.Type, isStatic:Boolean, metaData:Array = null)
          {
               super(metaData);
               _name = name;
               _type = type;
               _declaringType = declaringType;
               _isStatic = isStatic;
          }
          
          public function get name() : String
          {
               return _name;
          }
          
          public function get declaringType() : as3reflect.Type
          {
               return _declaringType;
          }
          
          public function get type() : as3reflect.Type
          {
               return _type;
          }
          
          public function get isStatic() : Boolean
          {
               return _isStatic;
          }
     }
}
