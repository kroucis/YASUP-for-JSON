/*:
# Yet Another Swift Utility Package for JSON (YASUP for JSON)
### Copyright © Kyle Roucis 2016
#### v 1.0.0
*/
import UIKit

let j1 = "{\"foo\":\"bar\"}"
if let o1 = JSON.dictionaryFromJSON(string: j1)
{
    if let foo: String = o1.get("foo")
    {
        foo
    }
    JSON.stringWithJSONObject(o1) == j1
}

class Test : JSONConvertable
{
    let s: String
    let a = [ "sadf", 1, 1.2, true, NSNull() ]
    init(stuff: String)
    {
        self.s = stuff
    }

    required init?(dictionary: NSDictionary)
    {
        guard let s: String = dictionary.get("s") else
        {
            self.s = ""
            return nil
        }

        self.s = s
    }

    func toDictionary() -> NSDictionary?
    {
        return [ "_t" : "\(Test.self)", "s" : self.s, "a" : self.a ]
    }
}

let t0 = Test(stuff: "asfxzcv")
t0.toDictionary()
let t1 = Test(dictionary: t0.toDictionary()!)
t1?.toDictionary()

Test(dictionary: JSON.jsonObjectFromJSON(string: "{\"s\": \"YES!\"}") as! NSDictionary)?.s

JSON.stringWithJSONObject(t1?.toDictionary())
JSON.stringWithJSONObject(nil)
