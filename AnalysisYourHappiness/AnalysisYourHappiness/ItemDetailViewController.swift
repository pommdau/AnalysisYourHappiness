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

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var doneBarButton : UIBarButtonItem!  // 編集完了ボタン
    @IBOutlet weak var nameTextField : UITextField!      // item名の入力欄
    @IBOutlet weak var ratingLabel   : UILabel!          // 幸せ度のラベル
    @IBOutlet weak var ratingSlider  : UISlider!         // 幸せ度のスライダー
    @IBOutlet weak var priceTextField: UITextField!      // かかる費用
    @IBOutlet weak var timeTextField : UITextField!      // 幸せの継続期間
    
    weak var delegate: ItemDetailViewControllerDelegate?
    var itemToEdit: HappinessItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let itemToEdit = itemToEdit {    // 編集モードの場合
            title = "項目の編集"
            nameTextField.text      = itemToEdit.name
            doneBarButton.isEnabled = true
            ratingSlider.value      = Float(itemToEdit.rating)
            self.sliderValueChanged(self)
            if (itemToEdit.price == 0) {
                priceTextField.text = ""
            } else {
                priceTextField.text = String(itemToEdit.price)
            }
            timeTextField.text = String(itemToEdit.time)
        } else {
            title = "項目の追加"
        }
    }
    
    // MARK:- Table View Delegates
    override func tableView(_ tableView: UITableView,
                            willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    // MARK:- Actions
    @IBAction func done(_ sender: Any) {
        // 継続期間が0の場合はエラーを出す
        if  ceil(Double(timeTextField.text!)!) <= 0 {
            let alert = UIAlertController(title: "継続期間の入力エラー。",
                                          message: "0よりも大きい数値を入力してください。",
                                          preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK",
                                         style: .default,
                                         handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            return
        }
        
        
        if let itemToEdit = itemToEdit {
            itemToEdit.name   = nameTextField.text!
            itemToEdit.rating = Double(ratingLabel.text!)!  // UISliderからだと値がFloat->Doubleで値がずれるのでテキストから取得する
            if let newPrice = Int(priceTextField.text!) {
                itemToEdit.price  = newPrice
            } else {
                itemToEdit.price = 0
            }
            itemToEdit.time = Double(timeTextField.text!)!
            delegate?.itemDetailViewController(self, didFinishEditing: itemToEdit)
        } else {
            let item = HappinessItem()
            item.name   = nameTextField.text!
            item.rating = Double(ratingSlider.value)
            item.price  = Int(priceTextField.text!)!
            item.time   = Double(timeTextField.text!)!
            delegate?.itemDetailViewController(self, didFinishAdding: item)
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        var rating = ratingSlider.value
        rating = floor(rating * 10.0) / 10.0    // 0.1単位とする
        ratingSlider.value = rating
        ratingLabel.text   = "\(rating)"
    }
    
    // MARK:- Text Field Delegates
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        // 継続期間のテキストに入力があった場合
        if (textField === timeTextField) {
            let oldText     = textField.text!
            let stringRange = Range(range, in:oldText)!
            let newText     = oldText.replacingCharacters(in: stringRange,
                                                          with: string)
            doneBarButton.isEnabled = !newText.isEmpty
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // 継続期間のテキストがクリアされた場合
        if (textField === timeTextField) {
            doneBarButton.isEnabled = false
        }
        
        return true
    }
}
