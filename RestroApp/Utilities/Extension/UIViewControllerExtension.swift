//
//  UIViewControllerExtension.swift
//
//  Copyright © 2022 Khalid. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    
    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }

    

    
    func popToAuthenticationVC(controller: UIViewController){
        var startpop  = false
        var  array = self.navigationController!.viewControllers as Array
        
        for vc in self.navigationController!.viewControllers as Array {
            if vc.isKind(of: controller.classForCoder) {
                startpop = true
                
            }else {
                if startpop {
                    if let index = array.firstIndex(of: vc) {
                        array.remove(at: index)
                    }
                }
            }
        }
        self.navigationController?.viewControllers = array
    }
    
    func returnStringWithStar(secureText:String, countryCode:String) -> String{
        
        if secureText.contains("@"){
            
            guard let end = secureText.firstIndex(of: "@") else {
                return secureText
            }
            
            let startRange = secureText.startIndex..<end
            let endRange = end..<secureText.endIndex
            if secureText[startRange].count > 4 {
                let index = secureText.startIndex..<secureText.index(secureText.firstIndex(of: "@")!, offsetBy: -3)
                
                let endIndex = secureText.index(secureText.firstIndex(of: "@")!, offsetBy: -3)..<secureText.endIndex
                
                let newEmail = String(repeating: "*", count: secureText[index].count )   + secureText[endIndex]
                return  newEmail
            }
            else {
                let newEmail = String(repeating: "*", count: secureText[startRange].count )   + secureText[endRange]
                return  newEmail
            }
            
        }else{
            if  secureText.count > 5{
                
                let newQuery =  countryCode + String(repeating: "*", count: secureText.count - 4  ) + secureText[secureText.index(after: secureText.index(secureText.startIndex, offsetBy: 5))..<secureText.endIndex]
                
                return newQuery
                
            }else {
                let newQuery = countryCode + String(repeating: "*", count: secureText.count)
                
                return newQuery
            }
        }
    }
}
