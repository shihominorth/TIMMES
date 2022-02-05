//
//  File.swift
//  checklist
//
//  Created by 北島　志帆美 on 2020-03-27.
//  Copyright © 2020 北島　志帆美. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

struct LocalNortificationDelegate {
    
    var timezoneIdentifier: String?
    var date: Date?
    
    var year: Int?
    var month: Int?
    var day: Int?
    var hour: Int?
    var minute: Int?
    
    init(timezoneIdentifier: String, date: Date) {
        self.timezoneIdentifier = timezoneIdentifier
        self.date = date
    }
    
    func setNotificationDate(){
        
        let calendar = Calendar.current
        let comps = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self.date!)
        let dateComponents = DateComponents(calendar: Calendar(identifier: .gregorian), timeZone: TimeZone(identifier: timezoneIdentifier!), year: comps.year, month: comps.month, day: comps.day, hour: comps.hour, minute: comps.minute)
        
        let identifier = "main"
        
        let content = UNMutableNotificationContent()
        content.title = "Title"
        content.body = "Body"
        content.sound = UNNotificationSound.default
        
        
        
        let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let calendarRequest = UNNotificationRequest(identifier: identifier,
                                            content: content,
                                            trigger: calendarTrigger)

        UNUserNotificationCenter.current().add(calendarRequest, withCompletionHandler: nil)
    }
    
    func setNotificationDate(before miniute: Int){
           
        
        let calendar = Calendar.current
        let modifiedDate = calendar.date(byAdding: .minute, value: -1 * (miniute), to: self.date!)!

        let comps = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: modifiedDate)
           let dateComponents = DateComponents(calendar: Calendar(identifier: .gregorian), timeZone: TimeZone(identifier: timezoneIdentifier!), year: comps.year, month: comps.month, day: comps.day, hour: comps.hour, minute: comps.minute)
           
           let identifier = "main"
           
           let content = UNMutableNotificationContent()
           content.title = "Title"
           content.body = "Body"
           content.sound = UNNotificationSound.default
           
           
           
           let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
           let calendarRequest = UNNotificationRequest(identifier: identifier,
                                               content: content,
                                               trigger: calendarTrigger)

           UNUserNotificationCenter.current().add(calendarRequest, withCompletionHandler: nil)
       }
    
 
    
}
