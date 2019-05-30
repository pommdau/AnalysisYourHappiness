import UIKit

protocol ConditionsDetailViewControllerDelegate: class {
    func conditionsDetailViewControllerDidCancel(_ controller: ConditionsDetailViewController)
    func conditionsDetailViewController(_ controller: ConditionsDetailViewController, didFinishAdding sortType: sortTypeEnum)
    func conditionsDetailViewController(_ controller: ConditionsDetailViewController, didFinishEditing sortType: sortTypeEnum)
}

class ConditionsDetailViewController: UITableViewController, UITextFieldDelegate {
    weak var delegate: ConditionsDetailViewControllerDelegate?
    var lastCheckmarkedIndexPath: IndexPath!
    var selectedSortType: sortTypeEnum!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: 条件分岐をすること
        // 指定されているセルにチェックマークをつける
        lastCheckmarkedIndexPath = IndexPath(row: sortTypeEnum.priceDescending.rawValue, section: 0)
        if let cell = tableView.cellForRow(at: lastCheckmarkedIndexPath) {
            cell.accessoryType = .checkmark
        }
    }
    
    // MARK:- Actions
    @IBAction func cancel() {
        delegate?.conditionsDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        delegate?.conditionsDetailViewController(self, didFinishAdding: selectedSortType)
    }
    
    // MARK:- Table View Delegates
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            // 前回選択されていたセルのチェックを外す
            if let checkmarkedCell = tableView.cellForRow(at: lastCheckmarkedIndexPath) {
                checkmarkedCell.accessoryType = .none
            }
            cell.accessoryType = .checkmark
            lastCheckmarkedIndexPath = indexPath
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


