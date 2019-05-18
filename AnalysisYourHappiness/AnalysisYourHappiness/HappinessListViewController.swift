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
        let happinessItem_02 = HappinessItem()
        happinessItems.append(happinessItem_01)
        happinessItems.append(happinessItem_02)
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HappinessItem", for: indexPath)
            
            let item = happinessItems[indexPath.row]
            
            configureText(for: cell, with: item)
            return cell
    }
    
    func configureText(for cell: UITableViewCell, with item: HappinessItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        //    label.text = item.text
        label.text = "\(item.name)"
    }
    
}
