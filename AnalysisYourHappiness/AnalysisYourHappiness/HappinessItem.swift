//
//  HappinessItem.swift
//  AnalysisYourHappiness
//
//  Created by Hiroki Ikeuchi on 2019/05/18.
//  Copyright © 2019 ikeh1024. All rights reserved.
//

import Foundation
import UserNotifications

class HappinessItem: NSObject, Codable {
    var name   = "item name"
    var rating:Float = 3.0
    var price  = 0      // かかる費用
}
