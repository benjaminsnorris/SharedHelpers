/*
 |  _   ____   ____   _
 | | |‾|  ⚈ |-| ⚈  |‾| |
 | | |  ‾‾‾‾| |‾‾‾‾  | |
 |  ‾        ‾        ‾
 */

import Foundation

public extension Date {
    
    // MARK: - Formatters
    
    static fileprivate var ISO8601MillisecondFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }()
    
    static fileprivate var ISO8601SecondFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    static fileprivate var ISO8601YearMonthDayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static fileprivate var mediumDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    static fileprivate var dateAndTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    static fileprivate var fullDateAndTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        return formatter
    }()
    
    static fileprivate var fullDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    
    static fileprivate var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
    
    static fileprivate var dayAndMonthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMM d", options: 0, locale: Locale.current)
        return formatter
    }()
    
    static fileprivate var julianDayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "g"
        return formatter
    }()

    static fileprivate let parsingFormatters = [ISO8601MillisecondFormatter, ISO8601SecondFormatter, ISO8601YearMonthDayFormatter]
    
    static func fromISO8601String(_ dateString: String?) -> Date? {
        guard let dateString = dateString else { return nil }
        for formatter in parsingFormatters {
            if let date = formatter.date(from: dateString) {
                return date
            }
        }
        return .none
    }
    
    static func fromMillisecondsSince1970(_ milliseconds: Double) -> Date {
        let dateSeconds = milliseconds / 1000.0
        let dateInterval = TimeInterval(dateSeconds)
        let date = Date(timeIntervalSince1970: dateInterval)
        return date
    }
    
    
    // MARK: - Formatted computed vars
    
    /// E.g. "3:30 PM"
    var timeString: String {
        return Date.timeFormatter.string(from: self)
    }
    
    // E.g. "Nov 23, 1937"
    var monthDayYearString: String {
        return Date.mediumDateFormatter.string(from: self)
    }
    
    /// E.g. "Nov 23, 1937, 3:30 PM"
    var dateAndTimeString: String {
        return Date.dateAndTimeFormatter.string(from: self)
    }
    
    /// E.g. "Tuesday, November 23, 1937 at 3:30 PM"
    var fullDateAndTimeString: String {
        return Date.fullDateAndTimeFormatter.string(from: self)
    }
    
    /// E.g. "Tuesday, November 23, 1937"
    var fullDateString: String {
        return Date.fullDateFormatter.string(from: self)
    }
    
    /// E.g. "1937-11-23T15:30:00-0700"
    var iso8601DateAndTimeString: String {
        return Date.ISO8601SecondFormatter.string(from: self)
    }
    
    /// E.g. "1937-11-23T15:30:00.023-0700"
    var iso8601MillisecondString: String {
        return Date.ISO8601MillisecondFormatter.string(from: self)
    }
    
    /// E.g. "1937-11-23"
    var iso8601DateString: String {
        return Date.ISO8601YearMonthDayFormatter.string(from: self)
    }
    
    var millisecondsSince1970: TimeInterval {
        return round(self.timeIntervalSince1970 * 1000)
    }
    
    /// E.g. "Nov 23"
    var dayAndMonthString: String {
        return Date.dayAndMonthFormatter.string(from: self)
    }
    
    /// `Today`, `Yesterday`, `Tomorrow`, or month and day (e.g. Aug 15)
    var relativeDayAndMonthString: String {
        let calendar = Calendar.autoupdatingCurrent
        if calendar.isDateInYesterday(self) {
            return NSLocalizedString("Yesterday", comment: "Relative date string for previous day")
        }
        if calendar.isDateInToday(self) {
            return NSLocalizedString("Today", comment: "Relative date string for current day")
        }
        if calendar.isDateInTomorrow(self) {
            return NSLocalizedString("Tomorrow", comment: "Relative date string for next day")
        }
        return dayAndMonthString
    }
    
    /// `Today`, `Yesterday`, `Tomorrow`, or month and day, along with time (e.g. Aug 15, 3:30 PM)
    var relativeDayAndTimeString: String {
        return String.localizedStringWithFormat(NSLocalizedString("%@, %@", comment: "Relative date and time string. First parameter is relative date, second is time."), relativeDayAndMonthString, timeString)
    }
    
    
    // MARK: - Helper computed vars
    
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    var isYesterday: Bool {
        return Calendar.current.isDateInYesterday(self)
    }
    
    var isTomorrow: Bool {
        return Calendar.current.isDateInTomorrow(self)
    }
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: self)!
        return nextDay.startOfDay
    }

    var julianDay: Int {
        let dayString = Date.julianDayFormatter.string(from: self)
        return Int(dayString) ?? 0
    }

    var isInCurrentMonth: Bool {
        let now = Date()
        let calendar = Calendar.autoupdatingCurrent
        let components = calendar.dateComponents([.year, .month], from: now)
        guard let startOfMonth = calendar.date(from: components),
            let startOfNextMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonth)
            else { return false }
        return self >= startOfMonth && self < startOfNextMonth
    }
    
    /// The hour of the date
    var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
    /// The minute of the date
    var minute: Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    /// Rounds sender to the next half hour ex. 10:12 -> 10:30
    var nextHalfHour: Date {
        let currentMinutes = Calendar.current.component(.minute, from: self)
        guard currentMinutes != 0 && currentMinutes != 30 else { return self }
        
        if currentMinutes < 30, let next30Date = Calendar.current.date(bySetting: .minute, value: 30, of: self) {
            return next30Date
        } else if let nextHourDate = Calendar.current.date(byAdding: .minute, value: 60 - currentMinutes, to: self) {
            return nextHourDate
        } else {
            return self
        }
    }
    
    
    // MARK: - Functions
        
    func isSameDay(as date: Date) -> Bool {
        return Calendar.current.isDate(date, inSameDayAs: self)
    }
    
}


// MARK: - Time intervals on Int

public extension Int {
    
    var seconds: TimeInterval {
        return TimeInterval(self)
    }

    var minutes: TimeInterval {
        return TimeInterval(self * 60)
    }
    
    var hours: TimeInterval {
        return TimeInterval(minutes * 60)
    }
    
    var days: TimeInterval {
        return TimeInterval(hours * 24)
    }
    
    var weeks: TimeInterval {
        return TimeInterval(days * 7)
    }

}
