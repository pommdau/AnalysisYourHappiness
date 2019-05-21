//
//  HappinessListViewController.swift
//  AnalysisYourHappiness
//
//  Created by Hiroki Ikeuchi on 2019/05/18.
//  Copyright © 2019 ikeh1024. All rights reserved.
//

import UIKit

class HappinessListViewController: UITableViewController, UINavigationControllerDelegate, ItemDetailViewControllerDelegate {
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
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        
        happinessList.happinessItems[indexPath.section].remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    func configureText(for cell: UITableViewCell, with item: HappinessItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        //    label.text = item.text
        label.text = "[\(item.rating)] \(item.name)"
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
}
