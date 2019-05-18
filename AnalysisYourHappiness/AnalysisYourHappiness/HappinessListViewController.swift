//
//  HappinessListViewController.swift
//  AnalysisYourHappiness
//
//  Created by Hiroki Ikeuchi on 2019/05/18.
//  Copyright © 2019 ikeh1024. All rights reserved.
//

import UIKit

class HappinessListViewController: UITableViewController, UINavigationControllerDelegate {
    
    var happinessItems = [HappinessItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // make dummy data
        let happinessItem_01 = HappinessItem()
        happinessItem_01.rating = 4.5
        let happinessItem_02 = HappinessItem()
        happinessItem_02.rating = 3.0
        let happinessItem_03 = HappinessItem()
        happinessItem_03.rating = 1.0
        let happinessItem_04 = HappinessItem()
        happinessItem_04.rating = 2.0
        happinessItems.append(happinessItem_01)
        happinessItems.append(happinessItem_02)
        happinessItems.append(happinessItem_03)
        happinessItems.append(happinessItem_04)
        
        sortHappinessItems()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK:- Table View Delegates
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return happinessItems.count
    }
    
    // セルの表示を行う
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HappinessItem", for: indexPath)
            let item = happinessItems[indexPath.row]
            
            configureText(for: cell, with: item)
            return cell
    }
    
    // セクション数を返す
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // セクションタイトルを返す
    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            return "評価が4.5以上"
//        } else if section == 1 {
//            return "評価が3以上"
//        }
        return "<section title dummy>"
    }
    
    func configureText(for cell: UITableViewCell, with item: HappinessItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        //    label.text = item.text
        label.text = "[\(item.rating)] \(item.name)"
    }
    
    // MARK:- HappinessItemMethod
    // TODO: 別クラスにリストを作ってもいいかも
    func sortHappinessItems() {
        // まずはRatingを降順で並べる
//        lists.sort(by: { list1, list2 in
//            return list1.name.localizedStandardCompare(list2.name) == .orderedAscending })
        happinessItems.sort(by: { item1, item2 in
            item1.rating > item2.rating // レーティングを降順でソートする
        })
    }
}
