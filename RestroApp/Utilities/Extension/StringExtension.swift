//
//  StringExtension.swift
//  Khalid
//
//  Created by Khalid Moin on 07/02/20.
//  Copyright © 2022 Khalid. All rights reserved.
//

//"^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"

import Foundation


extension String
{
    // To Check Whether Email is valid
    func isEmail() -> Bool
    {
        let emailRegex = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@" + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$" as String
        let emailText = NSPredicate(format: "SELF MATCHES %@",emailRegex)
        let isValid  = emailText.evaluate(with: self) as Bool
        return isValid
    }
    
    func isValidPasswordNew() -> Bool {
        let regularExpression = "^(?=.*\\d)(?=.*[A-Z]).{8,255}$"
        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)
        
        return passwordValidation.evaluate(with: self)
    }
    
    func isValidReferral() -> Bool{
        let alphaNumericRegEx = ".*[^A-Za-z0-9].*"
        let predicate = NSPredicate(format:"SELF MATCHES %@", alphaNumericRegEx)
        let isLegal = predicate.evaluate(with: self) as Bool
        return isLegal
    }
    
    // To Check Whether Email is valid
    func isValidString() -> Bool
    {
        if self == "<null>" || self == "(null)"
        {
            return false
        }
        return true
    }
    
    // To Check Whether Phone Number is valid
    func isPhoneNumber() -> Bool {
        if self.isStringEmpty() {
            return false
        }
        let phoneRegex = "^\\d{4,16}$"
        let phoneText = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let isValid = phoneText.evaluate(with: self) as Bool
        return isValid
    }
    
    // To Check Whether URL is valid
    func isURL() -> Bool {
        let urlRegex = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+" as String
        let urlText = NSPredicate(format: "SELF MATCHES %@", urlRegex)
        let isValid = urlText.evaluate(with: self) as Bool
        return isValid
    }
    
    
    
    // To Check Whether Image URL is valid
    func isImageURL() -> Bool {
        if self.isURL() {
            if self.range(of: ".png") != nil || self.range(of: ".jpg") != nil || self.range(of: ".jpeg") != nil {
                return true
            }
            else {
                return false
            }
        }
        else {
            return false
        }
    }
    
    static func getString(_ message: Any?) -> String
    {
        guard let strMessage = message as? String else
        {
            guard let doubleValue = message as? Double else
            {
                guard let intValue = message as? Int else
                {
                    guard let int64Value = message as? Int64 else
                    {
                        return ""
                    }
                    return String(int64Value)
                }
                return String(intValue)
            }
         
            
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 4
            formatter.minimumIntegerDigits = 1
            formatter.groupingSeparator = ""
            formatter.locale = Locale(identifier: "en_US")
            formatter.numberStyle = .decimal
            
            guard let formattedNumber = formatter.string(from: NSNumber(value: doubleValue)) else
            {
                return ""
            }
            return formattedNumber
        }
        
        return strMessage.stringByTrimmingWhiteSpaceAndNewLine()
    }
    
    static func getStringWithoutSeperation(_ message: Any?) -> String
    {
        guard let strMessage = message as? String else
        {
            guard let doubleValue = message as? Double else
            {
                guard let intValue = message as? Int else
                {
                    guard let int64Value = message as? Int64 else
                    {
                        return ""
                    }
                    return String(int64Value)
                }
                return String(intValue)
            }
            
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 4
            formatter.minimumIntegerDigits = 1
            
            guard let formattedNumber = formatter.string(from: NSNumber(value: doubleValue)) else
            {
                return ""
            }
            return formattedNumber
        }
        return strMessage.stringByTrimmingWhiteSpaceAndNewLine()
    }
    
    
    static func getStringWithCommaSeperator(_ message: Any?) -> String
    {
        guard let strMessage = message as? String else
        {
            guard let doubleValue = message as? Double else
            {
                guard let intValue = message as? Int else
                {
                    guard let int64Value = message as? Int64 else
                    {
                        return ""
                    }
                    return String(int64Value)
                }
                return String(intValue)
            }
            
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 6
            formatter.minimumIntegerDigits = 1
            formatter.groupingSeparator = ","
            formatter.locale = Locale(identifier: "en_US")
            formatter.numberStyle = .decimal
            
            guard let formattedNumber = formatter.string(from: NSNumber(value: doubleValue)) else
            {
                return ""
            }
            print(formattedNumber)
            return formattedNumber
        }
        return strMessage.stringByTrimmingWhiteSpaceAndNewLine()
    }
    
    static func getLength(_ message: Any?) -> Int
    {
        return String.getString(message).stringByTrimmingWhiteSpaceAndNewLine().count
    }
    
    static func checkForValidNumericString(_ message: AnyObject?) -> Bool
    {
        guard let strMessage = message as? String else
        {
            return true
        }
        
        if strMessage == "" || strMessage == "0"
        {
            return true
        }
        
        return false
    }
    
    
    // To Check Whether String is empty
    func isStringEmpty() -> Bool
    {
        return self.stringByTrimmingWhiteSpace().count == 0 ? true : false
    }
    
    mutating func removeSubString(subString: String) -> String
    {
        if self.contains(subString)
        {
            guard let stringRange = self.range(of: subString) else { return self }
            return self.replacingCharacters(in: stringRange, with: "")
        }
        return self
    }
    
    /*
     // To check whether String contains Only Letters
     func stringContainsOnlyLetters() -> Bool
     {
     let characterSet = NSCharacterSet.letterCharacterSet()
     return self.rangeOfCharacterFromSet(characterSet) != nil ? true : false
     }
     
     // To check whether String contains Only Numbers
     func stringContainsOnlyNumbers() -> Bool
     {
     let characterSet = NSCharacterSet.decimalDigitCharacterSet()
     return self.rangeOfCharacterFromSet(characterSet) != nil ? true : false
     }
     */
    
    // Get string by removing White Space & New Line
    func stringByTrimmingWhiteSpaceAndNewLine() -> String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    
    // Get string by removing White Space
    func stringByTrimmingWhiteSpace() -> String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    func getSubStringFrom(end: NSInteger) -> String
    {
        if self.count > end {
            let index = self.index(self.startIndex, offsetBy: end)
            let mySubstring = self[..<index]
            return String(mySubstring) + "..."
        }
        else{
            return self
        }
    }
    
    var encodeEmoji: String? {
        
        guard let data = self.data(using: String.Encoding.utf8) else {
            return nil
        }
        return data.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    }
    
    var decodeEmoji: String? {
        
        guard let data = NSData(base64Encoded: self, options: NSData.Base64DecodingOptions(rawValue: 0)) else {
            return nil
        }
        return String(data: data as Data, encoding: String.Encoding.utf8)
    }
    
}

////MARK: - isValidPasswordNew Regix
//extension String {
//    func isValidPasswordNew() -> Bool {
//        let regularExpression = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
//        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)
//
//        return passwordValidation.evaluate(with: self)
//    }
//}



