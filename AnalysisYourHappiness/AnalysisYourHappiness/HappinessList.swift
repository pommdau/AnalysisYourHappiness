//
//  HappinessList.swift
//  AnalysisYourHappiness
//
//  Created by Hiroki Ikeuchi on 2019/05/18.
//  Copyright © 2019 ikeh1024. All rights reserved.
//

import UIKit

enum sortTypeEnum:Int {
    case costPerformanceDescening
    case ratingDescending
    case priceAscending
}

class HappinessList: NSObject {
    
    var sortType              :sortTypeEnum!      // セクションの分類方法
    var numberOfSections      :Int!
    var numberOfRowsInSection :[Int]!
    var sectionTitles         :[String]!
    var happinessItems = [[HappinessItem]]()    // 項目の2次元配列（Section別）
    
    override init () {
        super.init()
        
        // TODO: firstTimeで入れるようにする＋UserDefaultsに保存する
        if sortType == nil {
//            sortType = sortTypeEnum.costPerformanceDescening
            sortType = sortTypeEnum.ratingDescending
//            sortType = sortTypeEnum.priceDescending
        }
        
        let happinessItem_01 = HappinessItem()
        happinessItem_01.name   = "新型macOS製品を購入"
        happinessItem_01.rating = 3.5
        happinessItem_01.time   = 24 * 3
        happinessItem_01.price  = 100000
        happinessItems.append([happinessItem_01])
        
        let happinessItem_02 = HappinessItem()
        happinessItem_02.name   = "子供の運動会に出る"
        happinessItem_02.rating = 5.0
        happinessItem_02.time   = 6
        happinessItem_02.price  = 0
        happinessItems.append([happinessItem_02])
        
        let happinessItem_03 = HappinessItem()
        happinessItem_03.name   = "読書をする"
        happinessItem_03.rating = 1.5
        happinessItem_03.time   = 2
        happinessItem_03.price  = 1000
        happinessItems.append([happinessItem_03])
        
        let happinessItem_04 = HappinessItem()
        happinessItem_04.name   = "旅行に行く"
        happinessItem_04.rating = 0.8
        happinessItem_04.time   = 12
        happinessItem_04.price  = 10000
        happinessItems.append([happinessItem_04])
        
        let happinessItem_05 = HappinessItem()
        happinessItem_05.name   = "映画を見に行く"
        happinessItem_05.rating = 2.9
        happinessItem_05.time   = 3
        happinessItem_05.price  = 3000
        happinessItems.append([happinessItem_05])
        
        arrangeHappinessItems()
    }
    
    // MARK:- HappinessItemMethod
    
    // アイテムを指定されたソートに応じて並び替える
    func arrangeHappinessItems() {
        
        // ソートのために２次元配列を1次配列に変換
        var happinessItemsTmp = [HappinessItem]()
        for happinessItemsInSection in happinessItems {
            for happinessItem in happinessItemsInSection {
                happinessItemsTmp.append(happinessItem)
            }
        }
        switch sortType! {
        case sortTypeEnum.ratingDescending: // レーティングの降順ソートの場合
            happinessItemsTmp.sort(by: { item1, item2 in
                item1.rating > item2.rating // レーティングを降順でソートする
            })
            numberOfSections = 5    // 4.0以上,3.0,2.0,1.0,0.0
            numberOfRowsInSection = [Int](repeating: 0, count: numberOfSections)
            sectionTitles = [String](repeating: "(dummy title)", count: 1)
            
            // セクションタイトルを決め打ちで決める
            sectionTitles.removeAll()
            sectionTitles.append("レーティング 4.0以上")
            sectionTitles.append("レーティング 3.0以上")
            sectionTitles.append("レーティング 2.0以上")
            sectionTitles.append("レーティング 1.0以上")
            sectionTitles.append("レーティング 1.0未満")
            
            // 配列の初期化
            happinessItems.removeAll()
            for _ in 0 ..< numberOfSections {
                happinessItems.append([HappinessItem]())
            }
            
            for happinessItem in happinessItemsTmp {
                let rating = happinessItem.rating
                if (rating >= 4) {
                    happinessItems[0].append(happinessItem)
                    numberOfRowsInSection[0] += 1
                } else if (rating >= 3) {
                    happinessItems[1].append(happinessItem)
                    numberOfRowsInSection[1] += 1
                } else if (rating >= 2) {
                    happinessItems[2].append(happinessItem)
                    numberOfRowsInSection[2] += 1
                } else if (rating >= 1) {
                    happinessItems[3].append(happinessItem)
                    numberOfRowsInSection[3] += 1
                } else if (rating >= 0) {
                    happinessItems[4].append(happinessItem)
                    numberOfRowsInSection[4] += 1
                }
            }
        case sortTypeEnum.costPerformanceDescening:
            happinessItemsTmp.sort(by: { item1, item2 in
                item1.costPerformance > item2.costPerformance // レーティングを降順でソートする
            })
            
            numberOfSections = 1
            numberOfRowsInSection = [Int](repeating: 0, count: numberOfSections)
            sectionTitles = [String](repeating: "(dummy title)", count: 1)
            
            // セクションタイトルを決め打ちで決める
            sectionTitles.removeAll()
            sectionTitles.append("コストパフォーマンス順")
            
            // 配列の初期化
            happinessItems.removeAll()
            for _ in 0 ..< numberOfSections {
                happinessItems.append([HappinessItem]())
            }
            
            for happinessItem in happinessItemsTmp {
                happinessItems[0].append(happinessItem)
                numberOfRowsInSection[0] += 1
            }
            
        case sortTypeEnum.priceAscending:
            happinessItemsTmp.sort(by: { item1, item2 in
                item1.price < item2.price // レーティングを降順でソートする
            })
            
            numberOfSections = 6    // 1万円以上 / 6000円以上 / 3000円以上 / 1000円以上 / 1000円未満 / 無料
            numberOfRowsInSection = [Int](repeating: 0, count: numberOfSections)
            sectionTitles = [String](repeating: "(dummy title)", count: 1)
            
            // セクションタイトルを決め打ちで決める
            sectionTitles.removeAll()
            sectionTitles.append("無料のもの")
            sectionTitles.append("1000円未満")
            sectionTitles.append("1000円以上")
            sectionTitles.append("3000円以上")
            sectionTitles.append("6000円以上")
            sectionTitles.append("10000円以上")
            
            // 配列の初期化
            happinessItems.removeAll()
            for _ in 0 ..< numberOfSections {
                happinessItems.append([HappinessItem]())
            }
        
            for happinessItem in happinessItemsTmp {
                let price = happinessItem.price
                if (price < 1) {
                    happinessItems[0].append(happinessItem)
                    numberOfRowsInSection[0] += 1
                } else if (price < 1000) {
                    happinessItems[1].append(happinessItem)
                    numberOfRowsInSection[1] += 1
                } else if (price < 3000) {
                    happinessItems[2].append(happinessItem)
                    numberOfRowsInSection[2] += 1
                } else if (price < 6000) {
                    happinessItems[3].append(happinessItem)
                    numberOfRowsInSection[3] += 1
                } else if (price < 10000) {
                    happinessItems[4].append(happinessItem)
                    numberOfRowsInSection[4] += 1
                } else {
                    happinessItems[5].append(happinessItem)
                    numberOfRowsInSection[5] += 1
                }
            }
        }
    }
    
    // TODO:フィルタリングをかける
    func filterWithPrice(lowestPrice: Int = 1, highestPrice: Int = 9999999) {
        // フィルタリングのために２次元配列を1次配列に変換
        //        var happinessItemsTmp = [HappinessItem]()
        //        for happinessItemsInSection in happinessItems {
        //            for happinessItem in happinessItemsInSection {
        //                happinessItemsTmp.append(happinessItem)
        //            }
        //        }
    }
}
