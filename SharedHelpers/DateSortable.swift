/*
 |  _   ____   ____   _
 | ⎛ |‾|  ⚈ |-| ⚈  |‾| ⎞
 | ⎝ |  ‾‾‾‾| |‾‾‾‾  | ⎠
 |  ‾        ‾        ‾
 */

import Foundation

protocol DateSortable {
    var sortDate: NSDate { get }
}


// MARK: - Sorting functions

extension CollectionType where Self.Generator.Element: DateSortable {
    
    func sortedByDate(ascending ascending: Bool = true) -> [Self.Generator.Element] {
        return self.sort(ascending ? sortAscending : sortDescending)
    }
    
    private func sortAscending(first: DateSortable, _ second: DateSortable) -> Bool {
        return first.sortDate.earlierDate(second.sortDate) == first.sortDate
    }

    private func sortDescending(first: DateSortable, _ second: DateSortable) -> Bool {
        return first.sortDate.laterDate(second.sortDate) == first.sortDate
    }

}
