import UIKit

protocol ConditionsDetailViewControllerDelegate: class {
    func conditionsDetailViewControllerDidCancel(_ controller: ConditionsDetailViewController)
    func conditionsDetailViewController(_ controller: ConditionsDetailViewController, didFinishEditing sortType: sortTypeEnum)
}

class ConditionsDetailViewController: UITableViewController, UITextFieldDelegate {
    weak var delegate: ConditionsDetailViewControllerDelegate?
    var lastCheckmarkedIndexPath: IndexPath!
    var selectedSortType: sortTypeEnum!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 現在の並び替えにチェックマークをつける（viewDidLoadではうまく行かなかった。描画のタイミングだろうか。）
        lastCheckmarkedIndexPath = IndexPath(row: selectedSortType.rawValue, section: 0)
        if let cell = tableView.cellForRow(at: lastCheckmarkedIndexPath) {
            cell.accessoryType = .checkmark
        }
        tableView.reloadData()
    }
    
    // MARK:- Actions
    @IBAction func cancel() {
        delegate?.conditionsDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        delegate?.conditionsDetailViewController(self, didFinishEditing: selectedSortType)
    }
    
    // MARK:- Table View Delegates
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            // 前回選択されていたセルのチェックを外す
            if let checkmarkedCell = tableView.cellForRow(at: lastCheckmarkedIndexPath) {
                checkmarkedCell.accessoryType = .none
            }
            cell.accessoryType       = .checkmark
            selectedSortType         = sortTypeEnum(rawValue: indexPath.row)
            lastCheckmarkedIndexPath = indexPath
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


