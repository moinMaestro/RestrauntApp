//
//  UILableExtension.swift
//
//  Copyright © 2022 Khalid. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
  func addCharacterSpacing(kernValue: Double) {
    if let labelText = text, labelText.count > 0 {
      let attributedString = NSMutableAttributedString(string: labelText)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length - 1))
      attributedText = attributedString
    }
  }
}
