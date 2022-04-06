//
//  CommonUtils.swift
//  Khalid
//
//  Created by Khalid Moin on 07/02/20.
//  Copyright © 2022 Khalid. All rights reserved.
//

import Foundation
import ProgressHUD

class CommonUtils {
    
    //Install any progress Hud... here SVProgress Hud Installed
    static func showHudWithNoInteraction(show: Bool) {
        
        ProgressHUD.animationType = .circleRotateChase//.lineScaling
        
        if show {
            ProgressHUD.show()
        } else {
            ProgressHUD.dismiss()
        }
    }
    
    static func showToast(message: String) {
        print(message)
    }
    
    
    //Convert difference of time stamp in to HH:MM:SS
    static func convertTimeStampToHour(unixtimeInterval:Double, dateFormat:String) -> String{

        let timeStamp = Int(unixtimeInterval)
        let hours = Int(timeStamp / 3600)
        let minutes = Int((timeStamp - hours * 3600) / 60)
        let sec     = Int((timeStamp - (hours * 3600 + minutes * 60)))
      
        let localDate = "\(Int.getInt(hours)):\(Int.getInt(minutes)):\(Int.getInt(sec))"
        
        return localDate
    }
    
    
    static func convertTimeStampToDaysAndHour(unixtimeInterval:Double) -> Dictionary<String, Any>{

        let timeStamp = Int(unixtimeInterval)
        
        let days = Int(timeStamp / 86400)
        let hours = Int((timeStamp - days * 86400) / 3600)
        let minutes = Int((timeStamp - (days * 86400 + hours * 3600)) / 60)
      
        let localDate = ["day":Int.getInt(days), "hour":Int.getInt(hours),"min":Int.getInt(minutes)]
        
        return localDate
    }
    
    
    static func convertTimeStampToDateTime(unixTimeInternval:Double, dataFormat:String) -> String{
        //Correctly Working for format "Tuesday, Mar 03, 2020" & timestamp is 13 digit
        let timeStamp = unixTimeInternval/1000
        
        let date = Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        
        if Calendar.current.isDateInToday(date) {
            dateFormatter.dateFormat = "HH:mm"
            return dateFormatter.string(from: date)
        }
        else if Calendar.current.isDateInYesterday(date){
            return "Yesterday"
        }
        else{
            dateFormatter.dateFormat = String.getString(dataFormat)
            return dateFormatter.string(from: date)
        }
    }
    
    static func convertDateToString(date:Date, format: String) -> String{
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = String.getString(format)//"EEEE, MMM dd, yyyy"
        let localDate = dateFormatter.string(from: date as Date)
        
        return localDate
    }
    
    
    static func convertTimeStampToTime(unixtimeInterval:Double, dateFormat:String) -> String{

        //Correctly Working for format "Tuesday, Mar 03, 2020" & timestamp is 13 digit
        let time = unixtimeInterval/1000

        let date = Date(timeIntervalSince1970: time)
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = String.getString(dateFormat)//"EEEE, MMM dd, yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        let localDate = dateFormatter.string(from: date as Date)

        return localDate
    }
    
    static func convertDateToString(date:Date) -> String{
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = String.getString("MM:dd:yy")//"EEEE, MMM dd, yyyy"
        let localDate = dateFormatter.string(from: date as Date)
        
        return localDate
    }
    
    static func convertDateToTimeString(date:Date) -> String{
        let dateFormatter = DateFormatter()
        
        if Calendar.current.isDateInToday(date) {
            dateFormatter.dateFormat = "HH:mm"
            return dateFormatter.string(from: date)
        }
        else if Calendar.current.isDateInYesterday(date){
            return "Yesterday"
        }
        else{
            dateFormatter.dateFormat = String.getString("EEEE, MMM dd")
            return dateFormatter.string(from: date)
        }
    }
}

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
    
    var dateFromDate : Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT:0)
        let str = formatter.string(from: self)
        return  formatter.date(from:str)
    }
}


