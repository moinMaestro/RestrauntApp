//
//  IntExtension.swift
//  Khalid
//
//  Created by Khalid Moin on 07/02/20.
//  Copyright © 2022 Khalid. All rights reserved.
//

import Foundation

extension Int
{
  static func getInt(_ value: Any?) -> Int
  {
    guard let intValue = value as? Int else
    {
      let strInt = String.getString(value)
      guard let intValueOfString = Int(strInt) else { return 0 }
      
      return intValueOfString
    }
    return intValue
  }
}

