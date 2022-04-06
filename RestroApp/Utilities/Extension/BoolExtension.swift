//
//  BoolExtension.swift
//
//  Copyright © 2022 Khalid. All rights reserved.
//

import Foundation

extension Bool
{
  static func getBool(_ value: Any?) -> Bool
  {
    guard let boolValue = value as? Bool else
    {
      let strBool = String.getString(value)
      guard let boolValueOfString = Bool(strBool) else { return false }
      
      return boolValueOfString
    }
    return boolValue
  }
}
