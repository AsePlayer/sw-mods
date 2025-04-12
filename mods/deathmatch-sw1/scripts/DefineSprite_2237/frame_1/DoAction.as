var so = SharedObject.getLocal("stickwar_save");
if(so.data.data.technology == undefined)
{
     loadButton._visible = false;
     loadButtonText._visible = false;
}
else
{
     loadButton._visible = true;
     loadButtonText._visible = true;
}
