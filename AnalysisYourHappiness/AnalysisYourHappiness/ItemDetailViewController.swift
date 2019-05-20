//
//  ItemDetailViewController.swift
//  AnalysisYourHappiness
//
//  Created by Hiroki Ikeuchi on 2019/05/19.
//  Copyright © 2019 ikeh1024. All rights reserved.
//

import UIKit

protocol ItemDetailViewControllerDelegate: class {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: HappinessItem)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: HappinessItem)
}

class ItemDetailViewController: UITableViewController {

    @IBOutlet weak var doneBarButton: UIBarButtonItem!  // 編集完了ボタン
    @IBOutlet weak var nameTextField: UITextField!      // item名の入力欄
    @IBOutlet weak var ratingLabel  : UILabel!
    @IBOutlet weak var ratingSlider : UISlider!
    @IBOutlet weak var costTextField: UITextField!
    
    weak var delegate: ItemDetailViewControllerDelegate?
    var itemToEdit: HappinessItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let itemToEdit = itemToEdit {    // 編集モードの場合
            title = "編集画面"
            nameTextField.text      = itemToEdit.name
            doneBarButton.isEnabled = true
            ratingSlider.value      = itemToEdit.rating
            self.sliderValueChanged(self)
            costTextField.text      = String(itemToEdit.price)
        }
    }

    // MARK: - Table view data source
    
    // MARK:- Table View Delegates
    override func tableView(_ tableView: UITableView,
                            willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    // MARK:- Actions
    @IBAction func done(_ sender: Any) {
        if let itemToEdit = itemToEdit {
//            itemToEdit.text         = textField.text!
//            itemToEdit.shouldRemind = shouldRemindSwitch.isOn
//            itemToEdit.dueDate      = dueDate
//            itemToEdit.scheduleNotification()
            delegate?.itemDetailViewController(self, didFinishEditing: itemToEdit)
        } else {
            let item          = HappinessItem()
//            item.text         = textField.text!
//            item.checked      = false
//            item.shouldRemind = shouldRemindSwitch.isOn
//            item.dueDate      = dueDate
//            item.scheduleNotification()
            
            delegate?.itemDetailViewController(self, didFinishAdding: item)
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        var rating = ratingSlider.value
        rating = floor(rating * 10.0) / 10.0    // 0.1単位とする
        ratingLabel.text = "幸せ度：\(rating)"
    }
}
