/*
 |  _   ____   ____   _
 | ⎛ |‾|  ⚈ |-| ⚈  |‾| ⎞
 | ⎝ |  ‾‾‾‾| |‾‾‾‾  | ⎠
 |  ‾        ‾        ‾
 */

import Foundation

public extension Date {
    
    // MARK: - Formatters
    
    static private var ISO8601MillisecondFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let tz = TimeZone(abbreviation:"GMT")
        formatter.timeZone = tz
        return formatter
    }
    
    static private var ISO8601SecondFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let tz = TimeZone(abbreviation:"GMT")
        formatter.timeZone = tz
        return formatter
    }
    
    static private var ISO8601YearMonthDayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    static private var dateAndTimeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
    
    static private var dayAndMonthFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMM d", options: 0, locale: Locale.current)
        return formatter
    }
    
    static private let parsingFormatters = [ISO8601MillisecondFormatter, ISO8601SecondFormatter, ISO8601YearMonthDayFormatter]
    
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
    
    public var dateAndTimeString: String {
        return Date.dateAndTimeFormatter.string(from: self)
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
        let calender = Calendar.current
        let flags: Set<Calendar.Component> = [.day, .month, .year]
        let componentsOne = calender.dateComponents(flags, from: self)
        let componentsTwo = calender.dateComponents(flags, from: now)
        return (componentsOne.day == componentsTwo.day && componentsOne.month == componentsTwo.month && componentsOne.year == componentsTwo.year)
    }
    
    public var startOfDay: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.era, .year, .month, .day], from: self)
        let startOfDate = calendar.date(from: components)!
        return startOfDate
    }
    
    public var endOfDay: Date {
        let calendar = Calendar.current
        let nextDay = calendar.date(byAdding: .day, value: 1, to: self)!
        let components = calendar.dateComponents([.era, .year, .month, .day], from: nextDay)
        let startOfDate = calendar.date(from: components)!
        return startOfDate
    }
    
}
