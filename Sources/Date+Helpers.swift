/*
 |  _   ____   ____   _
 | ⎛ |‾|  ⚈ |-| ⚈  |‾| ⎞
 | ⎝ |  ‾‾‾‾| |‾‾‾‾  | ⎠
 |  ‾        ‾        ‾
 */

import Foundation

public extension Date {
    
    // MARK: - Formatters
    
    static fileprivate var ISO8601MillisecondFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }
    
    static fileprivate var ISO8601SecondFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }
    
    static fileprivate var ISO8601YearMonthDayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    static fileprivate var dateAndTimeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
    
    static fileprivate var fullDateAndTimeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        return formatter
    }
    
    static fileprivate var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }
    
    static fileprivate var dayAndMonthFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMM d", options: 0, locale: Locale.current)
        return formatter
    }
    
    static fileprivate let parsingFormatters = [ISO8601MillisecondFormatter, ISO8601SecondFormatter, ISO8601YearMonthDayFormatter]
    
    static public func fromISO8601String(_ dateString:String) -> Date? {
        for formatter in parsingFormatters {
            if let date = formatter.date(from: dateString) {
                return date
            }
        }
        return .none
    }
    
    static public func fromMillisecondsSince1970(_ milliseconds: Double) -> Date {
        let dateSeconds = milliseconds / 1000.0
        let dateInterval = TimeInterval(dateSeconds)
        let date = Date(timeIntervalSince1970: dateInterval)
        return date
    }
    
    
    // MARK: - Formatted computed vars
    
    public var timeString: String {
        return Date.timeFormatter.string(from: self)
    }
    
    public var dateAndTimeString: String {
        return Date.dateAndTimeFormatter.string(from: self)
    }
    
    public var fullDateAndTimeString: String {
        return Date.fullDateAndTimeFormatter.string(from: self)
    }
    
    public var iso8601DateAndTimeString: String {
        return Date.ISO8601SecondFormatter.string(from: self)
    }
    
    public var iso8601MillisecondString: String {
        return Date.ISO8601MillisecondFormatter.string(from: self)
    }
    
    public var iso8601DateString: String {
        return Date.ISO8601YearMonthDayFormatter.string(from: self)
    }
    
    public var millisecondsSince1970: TimeInterval {
        return round(self.timeIntervalSince1970 * 1000)
    }
    
    public var dayAndMonthString: String {
        return Date.dayAndMonthFormatter.string(from: self)
    }
    
    
    // MARK: - Helper computed vars
    
    public var isToday: Bool {
        let now = Date()
        return isSameDay(as: now)
    }
    
    public var startOfDay: Date {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.era, .year, .month, .day], from: self)
        let startOfDate = calendar.date(from: components)!
        return startOfDate
    }
    
    public var endOfDay: Date {
        let calendar = Calendar.current
        let nextDay = (calendar as NSCalendar).date(byAdding: .day, value: 1, to: self, options: [])!
        let components = (calendar as NSCalendar).components([.era, .year, .month, .day], from: nextDay)
        let startOfDate = calendar.date(from: components)!
        return startOfDate
    }
    
    
    // MARK: - Functions
    
    /**
     Rounds down a date by the specified minutes. For use with `UIDatePicker` to
     determine the display date when using a `minuteInterval` greater than 1.
     
     - parameter minutes: Number of minutes to use in rounding. When used together
        with `UIDatePicker`, this should match the `minuteInterval`.
     */
    public func rounded(minutes: Int) -> Date {
        let calendar = NSCalendar.current
        var components = calendar.dateComponents([.minute], from: self)
		guard let originalMinutes = components.minute else { return self }
        let extraMinutes = originalMinutes % minutes
        let rounded = extraMinutes / minutes
        let adjustedMinutes: Int
        if rounded == 0 {
            adjustedMinutes = -extraMinutes
        } else {
            adjustedMinutes = minutes - extraMinutes
        }
        components.minute = adjustedMinutes
        guard let roundedDate = calendar.date(byAdding: components, to: self) else { return self }
        return roundedDate
    }
    
    public func isSameDay(as date: Date) -> Bool {
        let calender = Calendar.current
        let components: Set<Calendar.Component> = [.day, .month, .year]
        let componentsOne = calender.dateComponents(components, from: self)
        let componentsTwo = calender.dateComponents(components, from: date)
        return componentsOne.day == componentsTwo.day && componentsOne.month == componentsTwo.month && componentsOne.year == componentsTwo.year
    }
    
}


// MARK: - Time intervals on Int

public extension Int {
    
    public var seconds: TimeInterval {
        return TimeInterval(self)
    }

    public var minutes: TimeInterval {
        return TimeInterval(self * 60)
    }
    
    public var hours: TimeInterval {
        return TimeInterval(minutes * 60)
    }
    
    public var days: TimeInterval {
        return TimeInterval(hours * 24)
    }

}
