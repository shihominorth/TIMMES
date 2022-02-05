//
//  callingCellList.swift
//  checklist
//
//  Created by 北島　志帆美 on 2019-11-11.
//  Copyright © 2019 北島　志帆美. All rights reserved.
//

import Foundation

class CallingCellList {
    var callingList :[callingCellItem] = []
//    
//    init() {
//        let row0Item = callingCellItem()
//        let row1Item = callingCellItem()
//        let row2Item = callingCellItem()
//        
//        row0Item.nameCallingFor = "Mako"
//        row1Item.nameCallingFor = "Risa"
//        row2Item.nameCallingFor = "Usshi"
//        
//        row0Item.localTime = "10:30 AM"
//        row1Item.localTime = "11:30 AM"
//        row2Item.localTime = "12:30 AM"
//        
//        row0Item.localName = "Vacouver"
//        row1Item.localName = "Vancouver"
//        row2Item.localName = "Vancouver"
//        
//        row0Item.localDate = "Fri, 01/11/2019"
//        row1Item.localDate = "Fri, 01/11/2019"
//        row2Item.localDate = "Fri, 01/11/2019"
//        
//        row0Item.destinationName = "Tokyo"
//        row1Item.destinationName = "Buenos Aires"
//        row2Item.destinationName = "Manilla"
//        
//        row0Item.jetLag = "+ 17 HRS"
//        row1Item.jetLag = "+ 17 HRS"
//        row2Item.jetLag = "+ 17 HRS"
//        
//        row0Item.destinationTime = "6:00 PM"
//        row1Item.destinationTime = "01:00 AM"
//        row2Item.destinationTime = "04:00 PM"
//        
//        row0Item.notification = "30 min earlier"
//        row1Item.notification = "30 min earlier"
//        row2Item.notification = "30 min earlier"
//        
//        row0Item.placeCallingAt = "mister dounuts"
//        row1Item.placeCallingAt = "mister dounuts"
//        row2Item.placeCallingAt = "mister dounuts"
//        
//        callingList.append(row0Item)
//        callingList.append(row1Item)
//        callingList.append(row2Item)
//    }
    
    func move(item: callingCellItem, to index:Int) {
        guard let currentIndex = callingList.index(of: item) else {
            return
        }
        callingList.remove(at: currentIndex)
        callingList.insert(item, at: index)
    }
    
    func remove(items: [callingCellItem]) {
        
        for item in items {
            if let index = items.index(of: item) {
                callingList.remove(at: index)
            }
        }
    }
    
    func newToDo(item: callingCellItem) -> callingCellItem {
        
        callingList.append(item)
        return item
    }
    
    
    
}
