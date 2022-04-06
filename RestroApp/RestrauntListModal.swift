//
//  RestrauntListModal.swift
//  RestroApp
//
//  Created by khalid moin on 09/03/22.
//

import Foundation

struct RestrauntModal{
    var icon: String
    var icon_background_color: String
    var icon_mask_base_uri: String
    var name: String
    var place_id: String
    var rating: Double
    var user_ratings_total: Double
    var vicinity: String
    
    init(data:[String:Any]){
        self.icon = String.getString(data["icon"])
        self.icon_background_color = String.getString(data["icon_background_color"])
        self.icon_mask_base_uri = String.getString(data["icon_mask_base_uri"])
        self.name = String.getString(data["name"])
        self.place_id = String.getString(data["place_id"])
        self.rating = Double.getDouble(data["rating"])
        self.vicinity = String.getString(data["vicinity"])
        self.user_ratings_total = Double.getDouble(data["user_ratings_total"])
    }
}
