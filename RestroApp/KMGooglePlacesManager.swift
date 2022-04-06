//
//  KMGooglePlacesManager.swift
//  RestroApp
//
//  Created by khalid moin on 11/03/22.
//

import Foundation
import GooglePlaces

final class GooglePlacesManger{
    
    static let shared = GooglePlacesManger()
    
    private let client = GMSPlacesClient.shared()
    
    private init(){
    }
    
    public func setUp(){
        
    }
}
