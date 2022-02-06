//
//  KeyManager.swift
//  checklist
//
//  Created by 北島　志帆美 on 2020-02-03.
//  Copyright © 2020 北島　志帆美. All rights reserved.
//

import Foundation

struct KeyManager {

    private let keyFilePath = Bundle.main.path(forResource: "APIKey", ofType: "plist")

    func getKeys() -> NSDictionary? {
        guard let keyFilePath = keyFilePath else {
            return nil
        }
        return NSDictionary(contentsOfFile: keyFilePath)
    }

    func getValue(key: String) -> String? {
        guard let keys = getKeys() else {
            return nil
        }
        return keys[key] as! String
    }
}


