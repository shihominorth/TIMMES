//
//  extensions.swift
//  checklist
//
//  Created by 北島　志帆美 on 2020-03-05.
//  Copyright © 2020 北島　志帆美. All rights reserved.
//

import Foundation

extension Date {
    
    func convertToString(dateformat formatType: DateFormatType, timeZoneIdentifier: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: timeZoneIdentifier)
        dateFormatter.dateFormat = formatType.rawValue
        let newDate: String = dateFormatter.string(from: self)
        return newDate
    }
    
    func getTimeDifference(date: Date, LocalTimeZone: String, DestinationTimeZone: String) -> String {
        
        print(self.convertToString(dateformat: .dateWithTime, timeZoneIdentifier: LocalTimeZone))
        print(date.convertToString(dateformat: .dateWithTime, timeZoneIdentifier:  DestinationTimeZone))
        print(date.getHour(timeZoneIdentifier: LocalTimeZone))
        print(self.getHour(timeZoneIdentifier: DestinationTimeZone))
        
        let tupleLocaltime = self.getHour(timeZoneIdentifier: LocalTimeZone)
        let tupleDestinationtime = date.getHour(timeZoneIdentifier: DestinationTimeZone)
        
        if tupleLocaltime.date < tupleDestinationtime.date {
            var temp = 24 - tupleLocaltime.hour
            temp += tupleDestinationtime.hour
            if tupleDestinationtime.minute - tupleLocaltime.minute == 30 {
                return "+ \(temp) hours 30 mins"
            }
            return "+ \(temp) hours"
        }
        else if tupleLocaltime.date == tupleDestinationtime.date {
            
            if tupleDestinationtime.minute - tupleLocaltime.minute == 30 || tupleDestinationtime.minute - tupleLocaltime.minute == -30 {
                if tupleLocaltime.hour - tupleDestinationtime.hour > 0 {
                    return "- \(tupleLocaltime.hour - tupleDestinationtime.hour) hours 30 mins"
                }
                else if tupleLocaltime.hour - tupleDestinationtime.hour < 0 {
                    return "+ \(tupleDestinationtime.hour - tupleLocaltime.hour) hours 30 mins"
                }
            }
            else if tupleLocaltime.hour - tupleDestinationtime.hour > 0 {
                return "- \(tupleLocaltime.hour - tupleDestinationtime.hour) hours"
            }
            else if tupleLocaltime.hour - tupleDestinationtime.hour < 0 {
                return "+ \(tupleDestinationtime.hour - tupleLocaltime.hour) hours"
            }
            else {
                return "0 hour"
            }
        }
        
        var temp = 24 - tupleDestinationtime.hour
        temp += tupleLocaltime.hour
        if tupleDestinationtime.minute - tupleLocaltime.minute == 30 {
            return "+ \(temp) hours 30 mins"
        }
        return "- \(temp) hours"
        
    }
    
    func getHour(timeZoneIdentifier: String) -> (date: Int, hour:Int, minute: Int){
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: timeZoneIdentifier)
        
        dateFormatter.dateFormat = "HH"
        let hour = Int(dateFormatter.string(from: self))
        
        dateFormatter.dateFormat = "dd"
        let date = Int(dateFormatter.string(from: self))
        
        dateFormatter.dateFormat = "mm"
        let minute = Int(dateFormatter.string(from: self))
        
        return (date!, hour!, minute!)
    }
    
    func getDate(timeZoneIdentifier: String) -> (year: Int ,month: Int, day: Int, hour:Int){
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: timeZoneIdentifier)
        
        dateFormatter.dateFormat = "HH"
        let hour = Int(dateFormatter.string(from: self))
        
        dateFormatter.dateFormat = "dd"
        let day = Int(dateFormatter.string(from: self))
        
        dateFormatter.dateFormat = "MM"
        let month = Int(dateFormatter.string(from: self))
        
        dateFormatter.dateFormat = "yyyy"
        let year = Int(dateFormatter.string(from: self))
        
        return (year!, month!, day!, hour!)
    }
    
}


//MARK: can't convert
extension String {
    func convertStringToDate(dateformat formatType: DateFormatType, timeZoneIdentifier: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: timeZoneIdentifier)
        dateFormatter.dateFormat = formatType.rawValue
        let newDate: Date = dateFormatter.date(from: self)!
        return newDate
    }
}
