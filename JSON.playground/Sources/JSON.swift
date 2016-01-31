// YASUP for JSON v1.0.0
// Copyright © Kyle Roucis 2016

/*
 Simply copy this file into your project.
 */

import Foundation

/**
 [NSJSONSerialization]: https://developer.apple.com/library/ios/documentation/Foundation/Reference/NSJSONSerialization_Class/ "NSJSONSerialization Apple Documentation"
 Wraps the [NSJSONSerialization] Foundation functionality in an Optionals-oriented way to allow for more straightforward JSON handling.
 */
public class JSON
{
    public enum JSONError : ErrorType
    {
        case MissingData(String)
        case MalformedJSON
    }

    /**
     Attempts to convert JSON `data` into an `NSDictionary`.
     - Parameters:
        - data: The JSON `NSData` object to decode.
     - Returns: NSDictionary instance with the contents of the JSON data or nil if the data could not be decoded.
     */
    public class func dictionaryFromJSON(data data: NSData) -> NSDictionary?
    {
        return JSON.jsonObjectFromJSON(data: data) as? NSDictionary
    }

    /**
     Attempts to convert JSON `string` into an `NSDictionary` by converting `string` to an `NSData` and then attempting to decode the resulting `NSData`.
     - Parameters:
        - data: The JSON String object to decode.
     - Returns: NSDictionary instance with the contents of the JSON data or nil if the data could not be decoded.
     */
    public class func dictionaryFromJSON(string string: String, usingEncoding encoding: NSStringEncoding = NSUTF8StringEncoding) -> NSDictionary?
    {
        if let data = string.dataUsingEncoding(encoding)
        {
            return JSON.dictionaryFromJSON(data: data)
        }
        else
        {
            return nil
        }
    }

    /**
     Attempts to convert JSON `data` into an `NSArray`.
     - Parameters:
        - data: The JSON `NSData` object to decode.
     - Returns: NSArray instance with the contents of the JSON data or nil if the data could not be decoded.
     */
    public class func arrayFromJSON(data data: NSData) -> NSArray?
    {
        return JSON.jsonObjectFromJSON(data: data) as? NSArray
    }

    /**
     Attempts to convert JSON `string` into an `NSArray` by converting `string` to an `NSData` and then attempting to decode the resulting `NSData`.
     - Parameters:
        - data: The JSON String object to decode.
     - Returns: NSArray instance with the contents of the JSON data or nil if the data could not be decoded.
     */
    public class func arrayFromJSON(string string: String, usingEncoding encoding: NSStringEncoding = NSUTF8StringEncoding) -> NSArray?
    {
        if let data = string.dataUsingEncoding(encoding)
        {
            return JSON.arrayFromJSON(data: data)
        }
        else
        {
            return nil
        }
    }

    /**
     Attempts to convert JSON `data` into an object, decoded from the JSON.
     - Parameters:
        - data: The JSON `NSData` object to decode.
     - Returns: An object instance with the contents of the JSON data or nil if the data could not be decoded.
     */
    public class func jsonObjectFromJSON(data data: NSData) -> AnyObject?
    {
        do
        {
            let obj = try NSJSONSerialization.JSONObjectWithData(data, options: [ ])
            return obj
        }
        catch
        {
            return nil
        }
    }

    /**
     Attempts to convert JSON `string` into an object by converting `string` to an `NSData` and then attempting to decode the resulting `NSData`.
     - Parameters:
        - data: The JSON String object to decode.
     - Returns: An object instance with the contents of the JSON data or nil if the data could not be decoded.
     */
    public class func jsonObjectFromJSON(string string: String, usingEncoding encoding: NSStringEncoding = NSUTF8StringEncoding) -> AnyObject?
    {
        if let data = string.dataUsingEncoding(encoding)
        {
            return JSON.jsonObjectFromJSON(data: data)
        }
        else
        {
            return nil
        }
    }

    /**
     Attempts to convert `jsonObject` into valid JSON data.
     - Parameters:
        - data: The object to encode into JSON data.
     - Returns: An `NSData` instance with the encoded JSON data or nil if `jsonObject` is `nil` or cannot be converted to JSON data.
     */
    public class func dataWithJSONObject(jsonObject: AnyObject?) -> NSData?
    {
        guard let obj = jsonObject else
        {
            return nil
        }

        do
        {
            let data = try NSJSONSerialization.dataWithJSONObject(obj, options: [ ])
            return data
        }
        catch
        {
            return nil
        }
    }

    /**
     Attempts to convert `jsonObject` into valid JSON string.
     - Parameters:
        - data: The object to encode into JSON data.
     - Returns: A `String` instance with the encoded JSON string or nil if `jsonObject` is `nil` or cannot be converted to JSON string.
     */
    public class func stringWithJSONObject(jsonObject: AnyObject?, usingEncoding encoding: NSStringEncoding = NSUTF8StringEncoding) -> String?
    {
        guard let obj = jsonObject else
        {
            return nil
        }

        do
        {
            let data = try NSJSONSerialization.dataWithJSONObject(obj, options: [ ])
            if let str = String(data: data, encoding: encoding)
            {
                return str
            }
            else
            {
                return nil
            }
        }
        catch
        {
            return nil
        }
    }
}

/**
 Convert from and to JSON objects (`NSDictionary`)
 */
public protocol JSONConvertable
{
    init?(dictionary: NSDictionary)
    func toDictionary() -> NSDictionary?
}

public extension NSDictionary
{
    func getOrThrow<T>(key: String) throws -> T
    {
        guard let val = self[key] as? T else
        {
            throw JSON.JSONError.MissingData(key)
        }

        return val
    }

    func getOrThrow(key: String) throws -> Int
    {
        if let val = self[key] as? String,
            let i = Int(val)
        {
            return i
        }
        else if let val = self[key] as? Int
        {
            return val
        }
        else
        {
            throw JSON.JSONError.MissingData(key)
        }
    }

    func getOrThrow(key: String) throws -> Int32
    {
        if let val = self[key] as? String,
            let i = Int32(val)
        {
            return i
        }
        else if let val = self[key] as? Int
        {
            return Int32(val)
        }
        else
        {
            throw JSON.JSONError.MissingData(key)
        }
    }

    func getOrThrow(key: String) throws -> Int16
    {
        if let val = self[key] as? String,
            let i = Int16(val)
        {
            return i
        }
        else if let val = self[key] as? Int
        {
            return Int16(val)
        }
        else
        {
            throw JSON.JSONError.MissingData(key)
        }
    }

    func getOrThrow(key: String) throws -> Float
    {
        if let val = self[key] as? String,
            let f = Float(val)
        {
            return f
        }
        else if let val = self[key] as? Float
        {
            return val
        }
        else if let val = self[key] as? Int
        {
            return Float(val)
        }
        else
        {
            throw JSON.JSONError.MissingData(key)
        }
    }

    func getOrThrow(key: String) throws -> Double
    {
        if let val = self[key] as? String,
            let d = Double(val)
        {
            return d
        }
        else if let val = self[key] as? Double
        {
            return val
        }
        else if let val = self[key] as? Int
        {
            return Double(val)
        }
        else
        {
            throw JSON.JSONError.MissingData(key)
        }
    }

    func get<T>(key: String) -> T?
    {
        return self[key] as? T
    }

    func get(key: String) -> Int32?
    {
        guard let val = self[key] as? String else
        {
            return nil
        }

        return Int32(val)
    }

    func get(key: String) -> Int16?
    {
        guard let val = self[key] as? String else
        {
            return nil
        }

        return Int16(val)
    }

    func get(key: String) -> Float?
    {
        guard let val = self[key] as? String else
        {
            return nil
        }

        return Float(val)
    }

    func get(key: String) -> Double?
    {
        guard let val = self[key] as? String else
        {
            return nil
        }
        
        return Double(val)
    }
    
}