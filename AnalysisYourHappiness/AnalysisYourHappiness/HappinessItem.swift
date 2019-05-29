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
    var name   = "(item name)"
    var rating = 3.0
    var time   = 3.0  // 幸せ持続時間（hour）
    var price  = 1 // かかる費用(yen)
    var costPerformance: Double {   // コスパ = レーティング * 持続時間 / 費用
        get {
            let fixedRating = rating * 1000     // レートの補正
            return fixedRating * time / Double(price)
        }
    }
}
