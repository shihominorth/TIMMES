import Foundation
import UIKit


class GetTimeDifference {
    var localName: String?
    var destinationName: String?
    
    var date: Date?
    
    init(localName: String?, destinationName: String?, date: Date?) {
        
        self.localName = localName
        self.destinationName = destinationName
        self.date = date
    }
    
    //MARK: how to tell Date() timezone???
    // if i cant calculate it, im gonna use lat and log from cllocation
    
    func timeDifferenceWithCityNames() -> String {
        
        let currentLocalDate = Date()
        let currentDestinationDate = Date()
        
        let dateFormatterForLocal = DateFormatter()
        let dateFormatterForDestination = DateFormatter()
        
        
        
        dateFormatterForLocal.dateFormat = "yyyy/MM/dd HH:mm, EEE"
        dateFormatterForLocal.calendar = Calendar.current
        //        print(localName)
        dateFormatterForLocal.timeZone = TimeZone(identifier: self.localName ?? TimeZone.current.identifier)
        let localDateString = dateFormatterForLocal.string(from: currentLocalDate)
        let localDate = dateFormatterForLocal.date(from: localDateString)
        
        dateFormatterForDestination.dateFormat = "yyyy/MM/dd HH:mm, EEE"
        dateFormatterForDestination.timeZone = TimeZone(identifier: self.destinationName ?? TimeZone.current.identifier)
        dateFormatterForDestination.calendar = Calendar.current
        //        print(dateFormatterForDestination.timeZone)
        
        let destinationDateString = dateFormatterForLocal.string(from: currentDestinationDate)
        let destinationDate = dateFormatterForLocal.date(from: destinationDateString)!
        
        
        
        return localDate!.getTimeDifference(date: destinationDate, LocalTimeZone: localName!, DestinationTimeZone: destinationName!)
        
    }
    
    
    
//    func showLocalDateFromTimeDifference(timeDifference: String, destinationDate: Date) -> (year: Int, month:Int, day: Int, hour: Int) {
//        let tuple = destinationDate.getDate(timeZoneIdentifier: destinationName!)
//        let numTimeDifference = timeDifference.split(separator: " ").index(after: 0)
//
//        print(numTimeDifference)
//
//        if timeDifference.contains("+") {
//
//            let result =  tuple.hour - Int(numTimeDifference)
//
//            if result >= 0 {
//                //same day
//                return (tuple.year, tuple.month, tuple.day, result)
//            } else {
//                // yesterday
//
//                if tuple.month == 1 && tuple.day == 1 {
//                    return (tuple.year - 1, 12, 31, result - 24)
//                }
//
//                if tuple.month == 3 && tuple.day == 1 {
//
//                    if tuple.year % 400 == 0 {
//                        return (tuple.year, 2, 29, result - 24)
//                    }
//                    else if tuple.year % 100 == 0 {
//                        return (tuple.year, 3, 1, result - 24)
//                    }
//                    else if tuple.year % 4 == 0 {
//                        return (tuple.year, 2, 29, result - 24)
//                    }
//                    else {
//                        return (tuple.year, 2, 28, result - 24)
//                    }
//                }
//
//                switch tuple.month {
//                case 4, 6, 9, 11:
//                    if tuple.day == 30 {
//                        return (tuple.year, tuple.month - 1, 30, result - 24)
//                    }
//                    break
//                case 1, 3, 5, 7, 8, 10:
//                    if tuple.day == 31 {
//                        return (tuple.year, tuple.month - 1, 31, result - 24)
//                    }
//                    break
//                default:
//                    break
//                }
//
//                return (tuple.year, tuple.month, tuple.day - 1, 24 - result)
//            }
//
//        }
//        else if timeDifference.contains("-"){
//            let result =  Int(numTimeDifference) + tuple.hour
//
//
//            if result >= 23 {
//                // same day
//                return (tuple.year, tuple.month, tuple.day, result)
//            } else {
//                // tomorrow
//
//                if tuple.month == 12 && tuple.day == 31 {
//                    return (tuple.year + 1, 1, 1, result - 24)
//                }
//
//                if tuple.month == 2 && tuple.day == 28 {
//
//                    if tuple.year % 400 == 0 {
//                        return (tuple.year, 2, 29, result - 24)
//                    }
//                    else if tuple.year % 100 == 0 {
//                        return (tuple.year, 3, 1, result - 24)
//                    }
//                    else if tuple.year % 4 == 0 {
//                        return (tuple.year, 2, 29, result - 24)
//                    }
//                    else {
//                        return (tuple.year, 3, 1, result - 24)
//                    }
//                }
//
//                switch tuple.month {
//                case 4, 6, 9, 11:
//                    if tuple.day == 30 {
//                        return (tuple.year, tuple.month + 1, 1, result - 24)
//                    }
//                    break
//                case 1, 3, 5, 7, 8, 10:
//                    if tuple.day == 31 {
//                        return (tuple.year, tuple.month + 1, 1, result - 24)
//                    }
//                    break
//                default:
//                    break
//                }
//
//                return (tuple.year, tuple.month, tuple.day + 1, result - 24)
//            }
//        }
//        else {
//            return (tuple.year, tuple.month, tuple.day, tuple.hour)
//        }
//    }
    
}
