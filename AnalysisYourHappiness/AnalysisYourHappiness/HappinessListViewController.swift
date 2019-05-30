//
//  HappinessListViewController.swift
//  AnalysisYourHappiness
//
//  Created by Hiroki Ikeuchi on 2019/05/18.
//  Copyright © 2019 ikeh1024. All rights reserved.
//

import UIKit

class HappinessListViewController: UITableViewController,
    UINavigationControllerDelegate,
    ItemDetailViewControllerDelegate,
    ConditionsDetailViewControllerDelegate {
    
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
        return happinessList.numberOfRowsInSection[section]
    }
    
    // セルの表示を行う
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HappinessItem", for: indexPath)
            let item = happinessList.happinessItems[indexPath.section][indexPath.row]
            
            configureText(for: cell, with: item)
            return cell
    }
    
    // セクション数を返す
    override func numberOfSections(in tableView: UITableView) -> Int {
        return happinessList.numberOfSections
    }
    
    // セクションタイトルを返す
    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
        return happinessList.sectionTitles[section]
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        
        happinessList.happinessItems[indexPath.section].remove(at: indexPath.row)
        happinessList.arrangeHappinessItems()   // 削除した後はRowとSectionの数が変わっているので再計算が必要
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    func configureText(for cell: UITableViewCell, with item: HappinessItem) {
        let titleLabel     = cell.viewWithTag(1000) as! UILabel
        let subTitleLabel  = cell.viewWithTag(1001) as! UILabel
        titleLabel.text    = "\(item.name)"
        subTitleLabel.text = "【レート】\(item.rating)【費用】\(item.price)円【期間】\(item.time)時間"
    }
    
    // MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let controller = segue.destination as! ItemDetailViewController
            controller.delegate = self
        } else if segue.identifier == "EditItem" {
            let controller = segue.destination as! ItemDetailViewController
            controller.delegate = self
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = happinessList.happinessItems[indexPath.section][indexPath.row]
            }
        } else if segue.identifier == "EditConditions" {
            let controller = segue.destination as! ConditionsDetailViewController
            controller.delegate = self
            controller.selectedSortType = happinessList.sortType
        }
    }
    
    // MARK:- ItemDetailViewController Delegates
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        navigationController?.popViewController(animated:true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: HappinessItem) {
        happinessList.happinessItems[0].append(item)
        happinessList.arrangeHappinessItems()
        tableView.reloadData()
        
        navigationController?.popViewController(animated:true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: HappinessItem) {
        happinessList.arrangeHappinessItems()
        tableView.reloadData()
        navigationController?.popViewController(animated:true)
    }
    
    // MARK:- ConditionsDetailViewControllerDelegate
    func conditionsDetailViewControllerDidCancel(_ controller: ConditionsDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func conditionsDetailViewController(_ controller: ConditionsDetailViewController, didFinishEditing sortType: sortTypeEnum) {
        happinessList.sortType = sortType
        happinessList.arrangeHappinessItems()
        tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
    
    // MARK:- Actions
    // TODO:delete （デバッグ用）サンプルを追加する
    @IBAction func addSample(_ sender: Any) {
        
        // すでに5以上あれば無効とする
        var happinessItemsTmp = [HappinessItem]()
        for happinessItemsInSection in happinessList.happinessItems {
            for happinessItem in happinessItemsInSection {
                happinessItemsTmp.append(happinessItem)
            }
        }
        if (happinessItemsTmp.count >= 5) {
            return
        }
        
        UserDefaults.standard.set(true, forKey: "FirstTime")
        happinessList.handleFirstTime()
        tableView.reloadData()
    }
}
