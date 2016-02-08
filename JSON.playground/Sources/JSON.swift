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
        guard let val: T = self.get(key) else
        {
            throw JSON.JSONError.MissingData(key)
        }

        return val
    }

    func getOrThrow(key: String) throws -> Int
    {
        guard let val: Int = self.get(key) else
        {
            throw JSON.JSONError.MissingData(key)
        }

        return val
    }

    func getOrThrow(key: String) throws -> Int64
    {
        guard let val: Int64 = self.get(key) else
        {
            throw JSON.JSONError.MissingData(key)
        }

        return val
    }

    func getOrThrow(key: String) throws -> Int32
    {
        guard let val: Int32 = self.get(key) else
        {
            throw JSON.JSONError.MissingData(key)
        }

        return val
    }

    func getOrThrow(key: String) throws -> Int16
    {
        guard let val: Int16 = self.get(key) else
        {
            throw JSON.JSONError.MissingData(key)
        }

        return val
    }

    func getOrThrow(key: String) throws -> Float
    {
        guard let val: Float = self.get(key) else
        {
            throw JSON.JSONError.MissingData(key)
        }

        return val
    }

    func getOrThrow(key: String) throws -> Double
    {
        guard let val: Double = self.get(key) else
        {
            throw JSON.JSONError.MissingData(key)
        }

        return val
    }

    func get<T>(key: String) -> T?
    {
        return self[key] as? T
    }

    func get(key: String) -> Int?
    {
        if let val = self[key] as? Int
        {
            return val
        }
        else if let val = self[key] as? NSNumber
        {
            return val.integerValue
        }
        else if let str = self[key] as? String
        {
            return Int(str)
        }

        return nil
    }

    func get(key: String) -> Int64?
    {
        if let val = self[key] as? Int64
        {
            return val
        }
        else if let val = self[key] as? NSNumber
        {
            return val.longLongValue
        }
        else if let str = self[key] as? String
        {
            return Int64(str)
        }

        return nil
    }

    func get(key: String) -> Int32?
    {
        if let val = self[key] as? Int32
        {
            return val
        }
        else if let val = self[key] as? NSNumber
        {
            return val.intValue
        }
        else if let str = self[key] as? String
        {
            return Int32(str)
        }

        return nil
    }

    func get(key: String) -> Int16?
    {
        if let val = self[key] as? Int16
        {
            return val
        }
        else if let val = self[key] as? NSNumber
        {
            return Int16(val.intValue)
        }
        else if let str = self[key] as? String
        {
            return Int16(str)
        }

        return nil
    }

    func get(key: String) -> Float?
    {
        if let val = self[key] as? Float
        {
            return val
        }
        else if let val = self[key] as? NSNumber
        {
            return val.floatValue
        }
        else if let str = self[key] as? String
        {
            return Float(str)
        }

        return nil
    }

    func get(key: String) -> Double?
    {
        if let val = self[key] as? Double
        {
            return val
        }
        else if let val = self[key] as? NSNumber
        {
            return val.doubleValue
        }
        else if let str = self[key] as? String
        {
            return Double(str)
        }

        return nil
    }
    
}