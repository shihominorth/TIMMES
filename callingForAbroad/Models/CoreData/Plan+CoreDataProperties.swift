//
//  Plan+CoreDataProperties.swift
//  checklist
//
//  Created by 北島　志帆美 on 2020-04-11.
//  Copyright © 2020 北島　志帆美. All rights reserved.
//
//

import Foundation
import CoreData


extension Plan {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Plan> {
        return NSFetchRequest<Plan>(entityName: "Plan")
    }

    @NSManaged public var destinationName: String?
    @NSManaged public var destinationTime: Date?
    @NSManaged public var jetLag: String?
    @NSManaged public var localDate: Date?
    @NSManaged public var localName: String?
    @NSManaged public var nameCallingFor: String?
    @NSManaged public var notification: String?
    @NSManaged public var order: Int64
    @NSManaged public var placeCallingAt: String?

}
