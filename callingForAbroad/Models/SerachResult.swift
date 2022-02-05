//
//  SerachResult.swift
//  checklist
//
//  Created by 北島　志帆美 on 2020-02-03.
//  Copyright © 2020 北島　志帆美. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var id: String
    var icon: String
    var name: String
    var placeId: String
    var reference: String
    var types: [String]
    var vicinity: String
    var geometry: Geometry
    var photos: [Photo]
    var openingHours: [String:Bool]?
}
