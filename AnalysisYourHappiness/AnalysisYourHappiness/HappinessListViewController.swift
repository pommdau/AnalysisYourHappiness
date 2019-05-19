//
//  HappinessListViewController.swift
//  AnalysisYourHappiness
//
//  Created by Hiroki Ikeuchi on 2019/05/18.
//  Copyright © 2019 ikeh1024. All rights reserved.
//

import UIKit

class HappinessListViewController: UITableViewController, UINavigationControllerDelegate {
    
    var happinessList = HappinessList()

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        return happinessList.happinessItems[section].count
    }
    
    // セルの表示を行う
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HappinessItem", for: indexPath)
            let item = happinessList.happinessItems[indexPath.section][indexPath.row]
            
            configureText(for: cell, with: item)
            return cell
    }
    
    // セクション数を返す
    override func numberOfSections(in tableView: UITableView) -> Int {
        return happinessList.happinessItems.count
    }
    
    // セクションタイトルを返す
    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            return "評価が4.5以上"
//        } else if section == 1 {
//            return "評価が3以上"
//        }
        switch section {
        case 0:
            return "レーティング4.0以上"
        case 1:
            return "レーティング3.0以上"
        case 2:
            return "レーティング2.0以上"
        case 3:
            return "レーティング1.0以上"
        case 4:
            return "レーティング1.0未満"
        default:
            return "Error!"
        }
    }
    
    func configureText(for cell: UITableViewCell, with item: HappinessItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        //    label.text = item.text
        label.text = "[\(item.rating)] \(item.name)"
    }
    

}
