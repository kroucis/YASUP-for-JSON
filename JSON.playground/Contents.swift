/*:
 # Yet Another Swift Utility Package for JSON (YASUP for JSON)
 ### Copyright © Kyle Roucis 2016
 #### v 1.1.0
 */
import Foundation

/*:
 ## From JSON
 String
 */
let jsonString = "{\"foo\":\"bar\"}"
JSON.collectionFromJSON(string: jsonString)
JSON.jsonObjectFromJSON(string: jsonString)
JSON.jsonArrayFromJSON(string: jsonString)
/*:
 Data
 */
let jsonData = jsonString.data(using: .utf8)!
JSON.collectionFromJSON(data: jsonData)
JSON.jsonObjectFromJSON(data: jsonData)
JSON.jsonArrayFromJSON(data: jsonData)
/*:
 ## To JSON
 String
 */
let array: [ Any ] = [ "foo", 5 ]
let dict = [ "bar" : true ]
let empty: Any? = nil
JSON.stringWithJSONObject(jsonObject: array)
JSON.stringWithJSONObject(jsonObject: dict)
JSON.stringWithJSONObject(jsonObject: empty)
/*:
 Data
 */
JSON.dataWithJSONObject(jsonObject: array)
JSON.dataWithJSONObject(jsonObject: dict)
JSON.dataWithJSONObject(jsonObject: empty)
/*:
 Get Values
 */
let jsonObj = "{\"foo\":\"bar\",\"x\":[10]}"
if let obj = JSON.jsonObjectFromJSON(string: jsonObj)
{
    let x: [ Int ]? = obj.get("x")
    let foo: String? = try! obj.getOrThrow("foo")
}

let jsonAry = "[5,true,\"sup\"]"
if let ary = JSON.jsonArrayFromJSON(string: jsonAry)
{
    let val0: Int? = ary.get(0)
    let val1: Bool? = try! ary.getOrThrow(1)
}

/*:
 ## JSONConvertable Protocol
 */
struct Person : JSONConvertable
{
    let name: String
    let age: Int

    init(name: String, age: Int)
    {
        self.name = name
        self.age = age
    }

    init?(jsonObject: JSONObject)
    {
        guard let name: String = jsonObject.get("name"),
            let age: Int = jsonObject.get("age") else
        {
            return nil
        }

        self.name = name
        self.age = age
    }

    func toJSONObject() -> JSONObject?
    {
        return NSDictionary(dictionary: [
            "name" : self.name,
            "age" : self.age
            ])
    }
}
/*:
 From JSON
 */
let personJSON = "{\"name\":\"Doe\",\"age\":30}"
if let personDict = JSON.jsonObjectFromJSON(string: personJSON)
{
    Person(jsonObject: personDict)?.name
}
/*:
 To JSON
 */
let me = Person(name: "No", age: 100)
me.toJSONObject()
