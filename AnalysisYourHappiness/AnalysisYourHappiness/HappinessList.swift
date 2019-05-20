//
//  HappinessList.swift
//  AnalysisYourHappiness
//
//  Created by Hiroki Ikeuchi on 2019/05/18.
//  Copyright © 2019 ikeh1024. All rights reserved.
//

import UIKit

//enum sortTypeEnum:Int {
//    case ratingAscending
//    case ratingDescending
//}

class HappinessList: NSObject {
    
//    var sortType:sortTypeEnum    // セクションをどう分けているか
    var happinessItems = [[HappinessItem]]()
    
    override init () {
        let happinessItem_01 = HappinessItem()
        happinessItem_01.rating = 4.5
        let happinessItem_02 = HappinessItem()
        happinessItem_02.rating = 3.0
        let happinessItem_03 = HappinessItem()
        happinessItem_03.rating = 2.0
        let happinessItem_04 = HappinessItem()
        happinessItem_04.rating = 1.3
        let happinessItem_05 = HappinessItem()
        happinessItem_05.rating = 0.5
        happinessItems.append([happinessItem_01])
        happinessItems.append([happinessItem_02])
        happinessItems.append([happinessItem_03])
        happinessItems.append([happinessItem_04])
        happinessItems.append([happinessItem_05])
        
        super.init()
    }
    
    // MARK:- HappinessItemMethod
    func arrangeHappinessItems() {
        // まずはRatingを降順で並べる
        //        lists.sort(by: { list1, list2 in
        //            return list1.name.localizedStandardCompare(list2.name) == .orderedAscending })
        
        // ２次元配列を1次配列に変換
        var happinessItemsTmp = [HappinessItem]()
        for happinessItemsInSection in happinessItems {
            for happinessItem in happinessItemsInSection {
                happinessItemsTmp.append(happinessItem)
            }
        }
        
//        happinessItemsTmp.sort(by: { item1, item2 in
//            item1.rating > item2.rating // レーティングを降順でソートする
//        })
        
        happinessItemsTmp.sort(by: { item1, item2 in
            item1.rating > item2.rating // レーティングを降順でソートする
        })
        var happinessItemsWithOver4Rating = [HappinessItem]()
        var happinessItemsWithOver3Rating = [HappinessItem]()
        var happinessItemsWithOver2Rating = [HappinessItem]()
        var happinessItemsWithOver1Rating = [HappinessItem]()
        var happinessItemsWithOver0Rating = [HappinessItem]()
        for happinessItem in happinessItemsTmp {
            let rating = happinessItem.rating
            if (rating >= 4) {
                happinessItemsWithOver4Rating.append(happinessItem)
            } else if (rating >= 3) {
                happinessItemsWithOver3Rating.append(happinessItem)
            } else if (rating >= 2) {
                happinessItemsWithOver2Rating.append(happinessItem)
            } else if (rating >= 1) {
                happinessItemsWithOver1Rating.append(happinessItem)
            } else if (rating >= 0) {
                happinessItemsWithOver0Rating.append(happinessItem)
            }
        }
        happinessItems.removeAll()
        happinessItems.append(happinessItemsWithOver4Rating)
        happinessItems.append(happinessItemsWithOver3Rating)
        happinessItems.append(happinessItemsWithOver2Rating)
        happinessItems.append(happinessItemsWithOver1Rating)
        happinessItems.append(happinessItemsWithOver0Rating)
    }
}
