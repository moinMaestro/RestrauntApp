//
//  DoubleExtension.swift
//
//  Copyright © 2022 Khalid. All rights reserved.
//

import Foundation


extension Double
{
  static func getDouble(_ value: Any?) -> Double
  {
    guard let doubleValue = value as? Double else
    {
      let strDouble = String.getString(value)
      guard let doubleValueOfString = Double(strDouble) else { return 0.0 }
      
      return doubleValueOfString
    }
    return doubleValue
  }
}

