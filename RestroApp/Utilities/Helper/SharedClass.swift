//
//  SharedClass.swift
//
//  Copyright © 2022 Khalid. All rights reserved.
//

import Foundation

class SharedClass: NSObject
{
  static let sharedInstance = SharedClass()

  
  private override init()
  {
  }


  
  func getArray(_ array: Any?) -> [Any]
  {
    guard let arr = array as? [Any] else
    {
      return []
    }
    return arr
  }
  
  func getStringArray(_ array: Any?) -> [String]
  {
    guard let arr = array as? [String] else
    {
      return []
    }
    return arr
  }
    

  
  func getArray(withDictionary array: Any?) -> [Dictionary<String, Any>]
  {
    guard let arr = array as? [Dictionary<String, Any>] else
    {
      return []
    }
    return arr
  }
  
  func getDictionary(_ dictData: Any?) -> Dictionary<String, Any>
  {
    guard let dict = dictData as? Dictionary<String, Any> else
    {
      guard let arr = dictData as? [Any] else
      {
        return ["":""]
      }
      return getDictionary(arr.count > 0 ? arr[0] : ["":""])
    }
    return dict
  }
  
  func convertJSONToString(fromDict dict: Dictionary<String, Any>) -> String
  {
    do
    {
      let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
      return String.init(data: jsonData, encoding: .utf8) ?? ""
    }
    catch let error
    {
      print(error)
    }
    return ""
  }
  
  func convertStringToJSON(fromString strJSON: String) -> Dictionary<String, Any>
  {
    guard let data = strJSON.data(using: .utf8) else { return ["":""] }
    
    do
    {
      let dict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
      return getDictionary(dict)
    }
    catch let error
    {
      print(error)
    }
    return ["":""]
  }
}
