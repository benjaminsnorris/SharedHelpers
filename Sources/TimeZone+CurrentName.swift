/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import Foundation

public extension TimeZone {
    
    func localizedRelativeName(for style: NSTimeZone.NameStyle, locale: Locale?) -> String? {
        if self == TimeZone.current, let shortName = localizedName(for: .shortStandard, locale: locale) {
            return String.localizedStringWithFormat(NSLocalizedString("Current (%@)", comment: "Display for current time zone. Parameter is timezone abbreviation, e.g. Current (MST)"), shortName)
        } else {
            return localizedName(for: style, locale: locale)
        }
    }
    
}
