//
//  UserDefaultsExtension.swift
//  Khalid
//
//  Created by Khalid Moin on 07/02/20.
//  Copyright © 2022 Khalid. All rights reserved.


import Foundation

extension UserDefaults
{
    
    func isUserLoggedIn() -> Bool
    {
        return self.bool(forKey: kIsUserLoggedIn)
    }

    
    func getLoggedInAccessToken() -> String
    {
        return String.getString(self.string(forKey: kLoggedInAccessToken))
    }
   
}

