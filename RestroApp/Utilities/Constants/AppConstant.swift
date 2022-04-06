//
//  AppConstant.swift
//  Khalid
//
//  Created by Khalid Moin on 07/02/20.
//  Copyright © 2022 Khalid All rights reserved.

import Foundation
import UIKit


let sharedAppDelegate  = UIApplication.shared.delegate as! AppDelegate
let kSharedUserDefaults         = UserDefaults.standard
let kSharedInstance             = SharedClass.sharedInstance
let LOADER_THEME = UIColor.init(red: 129/255, green: 30/255, blue: 151/255, alpha: 1)
let kScreenWidth                = UIScreen.main.bounds.size.width
let kScreenHeight               = UIScreen.main.bounds.size.height

struct APIKeys {
    static let country_code                    = "country_code"
}

struct Keys {
    static let kDeviceToken = "deviceToken"
    static let kAccessToken = "token"
}

struct ServiceName {
    static let register                                   = "register"
}

struct StoryBoard {
    static let kStoryboardMain        = "Main"

}

struct viewControllerIdentifier {
}

struct ValidationMessage {
    static let emptyusename                     = "Please enter Mobile number/Email ID"
}





