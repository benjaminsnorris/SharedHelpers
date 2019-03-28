/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import UIKit

public extension UITableView {
    
    /// Reload table view and reselect any selected index paths
    ///
    /// - Parameter scrollPosition: Default value is `.none`
    func reloadDataPreservingSelection(at scrollPosition: UITableView.ScrollPosition = .none) {
        let selectedIndexPaths = indexPathsForSelectedRows
        reloadData()
        if let selected = selectedIndexPaths {
            selected.forEach { selectRow(at: $0, animated: false, scrollPosition: scrollPosition) }
        }
    }
    
    /// Deselect all selected cells
    ///
    /// - Parameter animated: Deselect cells using animation
    func deselectAll(animated: Bool) {
        guard let selected = indexPathsForSelectedRows else { return }
        selected.forEach { deselectRow(at: $0, animated: animated) }
    }
    
}
