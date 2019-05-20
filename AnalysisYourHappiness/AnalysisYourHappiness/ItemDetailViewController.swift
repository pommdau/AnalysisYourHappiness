//
//  ItemDetailViewController.swift
//  AnalysisYourHappiness
//
//  Created by Hiroki Ikeuchi on 2019/05/19.
//  Copyright © 2019 ikeh1024. All rights reserved.
//

import UIKit

class ItemDetailViewController: UITableViewController {

    @IBOutlet weak var doneBarButton: UIBarButtonItem!  // 編集完了ボタン
    @IBOutlet weak var nameTextField: UITextField!      // item名の入力欄
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingSlider: UISlider!
    @IBOutlet weak var costTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    
    // MARK:- Table View Delegates
    override func tableView(_ tableView: UITableView,
                            willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    // MARK:- Actions
    @IBAction func done(_ sender: Any) {
        
    }
    
    @IBAction func cancel(_ sender: Any) {
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        var rating = ratingSlider.value
        rating = floor(rating * 10.0) / 10.0    // 0.1単位とする
        ratingLabel.text = "幸せ度：\(rating)"
    }
    
}
