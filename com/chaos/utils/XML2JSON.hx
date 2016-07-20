package com.chaos.utils;
import openfl.utils.Object;



/**
	 * This takes an xml object and convert it into a flash json/object
	 * @author Erick Feiling
	 */
class XML2JSON
{
    public static var arrays(get, set) : Array<Object>;

    private static var _arrays : Array<Object>;
    
    public static function parse(node : Object) : Object
    {
        var obj : Dynamic = { };
        var numOfChilds : Int = node.children().length();
        
        for (i in 0...numOfChilds){
            var childNode : Dynamic = node.children()[i];
            var childNodeName : String = childNode.name();
            var value : Dynamic;
            
            if (childNode.children().length() == 1 && childNode.children()[0].name() == null) 
            {
                if (childNode.attributes().length() > 0) 
                {
                    value = {
                                _content : Std.string(childNode.children()[0])

                            };
                    var numOfAttributes : Int = childNode.attributes().length();
                    
                    for (j in 0...numOfAttributes){
                        value[Std.string(childNode.attributes()[j].name())] = childNode.attributes()[j];
                    }
                }
                else 
                {
                    value = Std.string(childNode.children()[0]);
                }
            }
            else 
            {
                value = parse(childNode);
            }
            
            if (Reflect.field(obj, childNodeName)) 
            {
                if (getTypeof(Reflect.field(obj, childNodeName)) == "array") 
                {
                    Reflect.field(obj, childNodeName).push(value);
                }
                else 
                {
                    Reflect.setField(obj, childNodeName, [Reflect.field(obj, childNodeName), value]);
                }
            }
            else if (isArray(childNodeName)) 
            {
                Reflect.setField(obj, childNodeName, [value]);
            }
            else 
            {
                Reflect.setField(obj, childNodeName, value);
            }
        }
        
        numOfAttributes = node.attributes().length();
        
        for (i in 0...numOfAttributes){
            obj[Std.string(node.attributes()[i].name())] = node.attributes()[i];
        }
        
        if (numOfChilds == 0) 
        {
            if (numOfAttributes == 0) 
            {
                obj = "";
            }
            else 
            {
                obj._content = "";
            }
        }
        return obj;
    }
    
    private static function get_arrays() : Array<Object>
    {
        if (_arrays == null) 
        {
            _arrays = [];
        }
        return _arrays;
    }
    
    private static function set_arrays(a : Array<Object>) : Array<Object>
    {
        _arrays = a;
        return a;
    }
    
    private static function isArray(nodeName : String) : Bool
    {
        var numOfArrays : Int = (_arrays != null) ? _arrays.length : 0;
        for (i in 0...numOfArrays){
            if (nodeName == _arrays[i]) 
            {
                return true;
            }
        }
        return false;
    }
    
    private static function getTypeof(o : Object) : String
    {
        if (as3hx.Compat.typeof((o)) == "object") 
        {
            if (o.length == null) 
            {
                return "object";
            }
            else if (as3hx.Compat.typeof((o.length)) == "number") 
            {
                return "array";
            }
            else 
            {
                return "object";
            }
        }
        else 
        {
            return as3hx.Compat.typeof((o));
        }
    }

    public function new()
    {
    }
}

