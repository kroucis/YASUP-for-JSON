// YASUP for JSON v1.1.0
// Copyright © Kyle Roucis 2016

/*
 Simply copy this file into your project.
 */

import Foundation

public protocol JSONObject
{
    func getOrThrow<T>(_ key: String) throws -> T
    func getOrThrow(_ key: String) throws -> Int
    func getOrThrow(_ key: String) throws -> Int64
    func getOrThrow(_ key: String) throws -> Int32
    func getOrThrow(_ key: String) throws -> Int16
    func getOrThrow(_ key: String) throws -> Float
    func getOrThrow(_ key: String) throws -> Double
    func getOrThrow(_ key: String) throws -> Bool
    func get<T>(_ key: String) -> T?
    func get(_ key: String) -> String?
    func get(_ key: String) -> Int?
    func get(_ key: String) -> Int64?
    func get(_ key: String) -> Int32?
    func get(_ key: String) -> Int16?
    func get(_ key: String) -> Float?
    func get(_ key: String) -> Double?
    func get(_ key: String) -> Bool?
    subscript(key: Any) -> Any? { get }
    var count: Int { get }
}

public protocol JSONArray
{
    func getOrThrow<T>(_ idx: Int) throws -> T
    func getOrThrow(_ idx: Int) throws -> Int
    func getOrThrow(_ idx: Int) throws -> Int64
    func getOrThrow(_ idx: Int) throws -> Int32
    func getOrThrow(_ idx: Int) throws -> Int16
    func getOrThrow(_ idx: Int) throws -> Float
    func getOrThrow(_ idx: Int) throws -> Double
    func getOrThrow(_ idx: Int) throws -> Bool
    func get<T>(_ idx: Int) -> T?
    func get(_ idx: Int) -> String?
    func get(_ idx: Int) -> Int?
    func get(_ idx: Int) -> Int64?
    func get(_ idx: Int) -> Int32?
    func get(_ idx: Int) -> Int16?
    func get(_ idx: Int) -> Float?
    func get(_ idx: Int) -> Double?
    func get(_ idx: Int) -> Bool?
    subscript(idx: Int) -> Any { get }
    var count: Int { get }
}

/**
 [NSJSONSerialization]: https://developer.apple.com/library/ios/documentation/Foundation/Reference/NSJSONSerialization_Class/ "NSJSONSerialization Apple Documentation"
 Wraps the [NSJSONSerialization] Foundation functionality in an Optionals-oriented way to allow for more straightforward JSON handling.
 */
public class JSON
{
    public enum JSONError : Error
    {
        case MissingData(String)
        case MalformedJSON
    }

    /**
     Attempts to convert JSON `data` into an `NSDictionary`.
     - Parameters:
     - data: The JSON `Data` object to decode.
     - Returns: NSDictionary instance with the contents of the JSON data or nil if the data could not be decoded.
     */
    public class func jsonObjectFromJSON(data: Data) -> JSONObject?
    {
        return JSON.collectionFromJSON(data: data) as? JSONObject
    }

    /**
     Attempts to convert JSON `string` into an `NSDictionary` by converting `string` to an `Data` and then attempting to decode the resulting `Data`.
     - Parameters:
     - string: The JSON String object to decode.
     - encoding: Encoding to be used for the resulting string. Default: .utf8
     - Returns: Dictionary instance with the contents of the JSON data or nil if the data could not be decoded.
     */
    public class func jsonObjectFromJSON(string: String, usingEncoding encoding: String.Encoding = .utf8) -> JSONObject?
    {
        if let data = string.data(using: encoding)
        {
            return JSON.jsonObjectFromJSON(data: data)
        }
        else
        {
            return nil
        }
    }

    /**
     Attempts to convert JSON `data` into an `NSArray`.
     - Parameters:
     - data: The JSON `Data` object to decode.
     - Returns: NSArray instance with the contents of the JSON data or nil if the data could not be decoded.
     */
    public class func jsonArrayFromJSON(data: Data) -> JSONArray?
    {
        return JSON.collectionFromJSON(data: data) as? JSONArray
    }

    /**
     Attempts to convert JSON `string` into an `NSArray` by converting `string` to an `Data` and then attempting to decode the resulting `Data`.
     - Parameters:
     - string: The JSON String object to decode.
     - encoding: Encoding to be used for the resulting string. Default: .utf8
     - Returns: NSArray instance with the contents of the JSON data or nil if the data could not be decoded.
     */
    public class func jsonArrayFromJSON(string: String, usingEncoding encoding: String.Encoding = .utf8) -> JSONArray?
    {
        if let data = string.data(using: encoding)
        {
            return JSON.jsonArrayFromJSON(data: data)
        }
        else
        {
            return nil
        }
    }

    /**
     Attempts to convert JSON `data` into an object, decoded from the JSON.
     - Parameters:
     - data: The JSON `Data` object to decode.
     - Returns: An object instance with the contents of the JSON data or nil if the data could not be decoded.
     */
    public class func collectionFromJSON(data: Data) -> Any?
    {
        do
        {
            let obj = try JSONSerialization.jsonObject(with: data, options: [ ])
            return obj
        }
        catch
        {
            return nil
        }
    }

    /**
     Attempts to convert JSON `string` into an object by converting `string` to an `Data` and then attempting to decode the resulting `Data`.
     - Parameters:
     - string: The JSON String object to decode.
     - encoding: Encoding to be used for the resulting string. Default: .utf8
     - Returns: An object instance with the contents of the JSON data or nil if the data could not be decoded.
     */
    public class func collectionFromJSON(string: String, usingEncoding encoding: String.Encoding = .utf8) -> Any?
    {
        if let data = string.data(using: encoding)
        {
            return JSON.collectionFromJSON(data: data)
        }
        else
        {
            return nil
        }
    }

    /**
     Attempts to convert `jsonObject` into valid JSON data.
     - Parameters:
     - jsonObject: The object to encode into JSON data.
     - Returns: A `Data` instance with the encoded JSON data or nil if `jsonObject` is `nil` or cannot be converted to JSON data.
     */
    public class func dataWithJSONObject(jsonObject: Any?) -> Data?
    {
        guard let obj = jsonObject else
        {
            return nil
        }

        do
        {
            let data = try JSONSerialization.data(withJSONObject: obj, options: [ ])
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
     - jsonObject: The object to encode into JSON data.
     - encoding: Encoding to be used for the resulting string. Default: .utf8
     - Returns: A `String` instance with the encoded JSON string or nil if `jsonObject` is `nil` or cannot be converted to JSON string.
     */
    public class func stringWithJSONObject(jsonObject: Any?, usingEncoding encoding: String.Encoding = .utf8) -> String?
    {
        guard let obj = jsonObject else
        {
            return nil
        }

        do
        {
            let data = try JSONSerialization.data(withJSONObject: obj, options: [ ])
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
    init?(jsonObject: JSONObject)
    func toJSONObject() -> JSONObject?
}

extension JSONObject
{
    public func getOrThrow<T>(_ key: String) throws -> T
    {
        guard let val: T = self.get(key) else
        {
            throw JSON.JSONError.MissingData(key)
        }

        return val
    }

    public func getOrThrow(_ key: String) throws -> Int
    {
        guard let val: Int = self.get(key) else
        {
            throw JSON.JSONError.MissingData(key)
        }

        return val
    }

    public func getOrThrow(_ key: String) throws -> Int64
    {
        guard let val: Int64 = self.get(key) else
        {
            throw JSON.JSONError.MissingData(key)
        }

        return val
    }

    public func getOrThrow(_ key: String) throws -> Int32
    {
        guard let val: Int32 = self.get(key) else
        {
            throw JSON.JSONError.MissingData(key)
        }

        return val
    }

    public func getOrThrow(_ key: String) throws -> Int16
    {
        guard let val: Int16 = self.get(key) else
        {
            throw JSON.JSONError.MissingData(key)
        }

        return val
    }

    public func getOrThrow(_ key: String) throws -> Float
    {
        guard let val: Float = self.get(key) else
        {
            throw JSON.JSONError.MissingData(key)
        }

        return val
    }

    public func getOrThrow(_ key: String) throws -> Double
    {
        guard let val: Double = self.get(key) else
        {
            throw JSON.JSONError.MissingData(key)
        }

        return val
    }

    public func getOrThrow(_ key: String) throws -> Bool?
    {
        guard let val: Bool = self.get(key) else
        {
            throw JSON.JSONError.MissingData(key)
        }

        return val
    }

    public func get<T>(_ key: String) -> T?
    {
        return self[key] as? T
    }

    public func get(_ key: String) -> Int?
    {
        if let val = self[key] as? Int
        {
            return val
        }
        else if let val = self[key] as? NSNumber
        {
            return val.intValue
        }
        else if let str = self[key] as? String
        {
            return Int(str)
        }

        return nil
    }

    public func get(_ key: String) -> Int64?
    {
        if let val = self[key] as? Int64
        {
            return val
        }
        else if let val = self[key] as? NSNumber
        {
            return val.int64Value
        }
        else if let str = self[key] as? String
        {
            return Int64(str)
        }

        return nil
    }

    public func get(_ key: String) -> Int32?
    {
        if let val = self[key] as? Int32
        {
            return val
        }
        else if let val = self[key] as? NSNumber
        {
            return val.int32Value
        }
        else if let str = self[key] as? String
        {
            return Int32(str)
        }

        return nil
    }

    public func get(_ key: String) -> Int16?
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

    public func get(_ key: String) -> Float?
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

    public func get(_ key: String) -> Double?
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

    public func get(_ key: String) -> Bool?
    {
        if let val = self[key] as? Bool
        {
            return val
        }
        else if let val = self[key] as? String
        {
            return val.caseInsensitiveCompare("true") == .orderedSame
        }
        else if let val = self[key] as? NSNumber
        {
            return val.boolValue
        }

        return nil
    }

}

extension JSONArray
{
    public func getOrThrow<T>(_ idx: Int) throws -> T
    {
        guard let val: T = self.get(idx) else
        {
            throw JSON.JSONError.MissingData("\(idx)")
        }

        return val
    }

    public func getOrThrow(_ idx: Int) throws -> Int
    {
        guard let val: Int = self.get(idx) else
        {
            throw JSON.JSONError.MissingData("\(idx)")
        }

        return val
    }

    public func getOrThrow(_ idx: Int) throws -> Int64
    {
        guard let val: Int64 = self.get(idx) else
        {
            throw JSON.JSONError.MissingData("\(idx)")
        }

        return val
    }

    public func getOrThrow(_ idx: Int) throws -> Int32
    {
        guard let val: Int32 = self.get(idx) else
        {
            throw JSON.JSONError.MissingData("\(idx)")
        }

        return val
    }

    public func getOrThrow(_ idx: Int) throws -> Int16
    {
        guard let val: Int16 = self.get(idx) else
        {
            throw JSON.JSONError.MissingData("\(idx)")
        }

        return val
    }

    public func getOrThrow(_ idx: Int) throws -> Float
    {
        guard let val: Float = self.get(idx) else
        {
            throw JSON.JSONError.MissingData("\(idx)")
        }

        return val
    }

    public func getOrThrow(_ idx: Int) throws -> Double
    {
        guard let val: Double = self.get(idx) else
        {
            throw JSON.JSONError.MissingData("\(idx)")
        }

        return val
    }

    public func getOrThrow(_ idx: Int) throws -> Bool?
    {
        guard let val: Bool = self.get(idx) else
        {
            throw JSON.JSONError.MissingData("\(idx)")
        }

        return val
    }

    public func get<T>(_ idx: Int) -> T?
    {
        return self[idx] as? T
    }

    public func get(_ idx: Int) -> Int?
    {
        if let val = self[idx] as? Int
        {
            return val
        }
        else if let val = self[idx] as? NSNumber
        {
            return val.intValue
        }
        else if let str = self[idx] as? String
        {
            return Int(str)
        }

        return nil
    }

    public func get(_ idx: Int) -> Int64?
    {
        if let val = self[idx] as? Int64
        {
            return val
        }
        else if let val = self[idx] as? NSNumber
        {
            return val.int64Value
        }
        else if let str = self[idx] as? String
        {
            return Int64(str)
        }

        return nil
    }

    public func get(_ idx: Int) -> Int32?
    {
        if let val = self[idx] as? Int32
        {
            return val
        }
        else if let val = self[idx] as? NSNumber
        {
            return val.int32Value
        }
        else if let str = self[idx] as? String
        {
            return Int32(str)
        }

        return nil
    }

    public func get(_ idx: Int) -> Int16?
    {
        if let val = self[idx] as? Int16
        {
            return val
        }
        else if let val = self[idx] as? NSNumber
        {
            return Int16(val.intValue)
        }
        else if let str = self[idx] as? String
        {
            return Int16(str)
        }

        return nil
    }

    public func get(_ idx: Int) -> Float?
    {
        if let val = self[idx] as? Float
        {
            return val
        }
        else if let val = self[idx] as? NSNumber
        {
            return val.floatValue
        }
        else if let str = self[idx] as? String
        {
            return Float(str)
        }

        return nil
    }

    public func get(_ idx: Int) -> Double?
    {
        if let val = self[idx] as? Double
        {
            return val
        }
        else if let val = self[idx] as? NSNumber
        {
            return val.doubleValue
        }
        else if let str = self[idx] as? String
        {
            return Double(str)
        }

        return nil
    }

    public func get(_ idx: Int) -> Bool?
    {
        if let val = self[idx] as? Bool
        {
            return val
        }
        else if let val = self[idx] as? String
        {
            return val.caseInsensitiveCompare("true") == .orderedSame
        }
        else if let val = self[idx] as? NSNumber
        {
            return val.boolValue
        }
        
        return nil
    }
    
}

extension NSArray : JSONArray
{
    
}

extension NSDictionary : JSONObject
{
    
}
