/*
 |  _   ____   ____   _
 | ⎛ |‾|  ⚈ |-| ⚈  |‾| ⎞
 | ⎝ |  ‾‾‾‾| |‾‾‾‾  | ⎠
 |  ‾        ‾        ‾
 */

import Foundation

public extension NSDate {
    
    // MARK: - Formatters
    
    static private var ISO8601MillisecondFormatter: NSDateFormatter {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }
    
    static private var ISO8601SecondFormatter: NSDateFormatter {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }
    
    static private var ISO8601YearMonthDayFormatter: NSDateFormatter {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    static private var dateAndTimeFormatter: NSDateFormatter {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .ShortStyle
        return formatter
    }
    
    static private var fullDateAndTimeFormatter: NSDateFormatter {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .FullStyle
        formatter.timeStyle = .ShortStyle
        return formatter
    }
    
    static private var timeFormatter: NSDateFormatter {
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        return formatter
    }
    
    static private var dayAndMonthFormatter: NSDateFormatter {
        let formatter = NSDateFormatter()
        formatter.dateFormat = NSDateFormatter.dateFormatFromTemplate("MMM d", options: 0, locale: NSLocale.currentLocale())
        return formatter
    }
    
    static private let parsingFormatters = [ISO8601MillisecondFormatter, ISO8601SecondFormatter, ISO8601YearMonthDayFormatter]
    
    static public func fromISO8601String(dateString:String) -> NSDate? {
        for formatter in parsingFormatters {
            if let date = formatter.dateFromString(dateString) {
                return date
            }
        }
        return .None
    }
    
    static public func fromMillisecondsSince1970(milliseconds: Double) -> NSDate {
        let dateSeconds = milliseconds / 1000.0
        let dateInterval = NSTimeInterval(dateSeconds)
        let date = NSDate(timeIntervalSince1970: dateInterval)
        return date
    }
    
    
    // MARK: - Formatted computed vars
    
    public var timeString: String {
        return NSDate.timeFormatter.stringFromDate(self)
    }
    
    public var dateAndTimeString: String {
        return NSDate.dateAndTimeFormatter.stringFromDate(self)
    }
    
    public var fullDateAndTimeString: String {
        return NSDate.fullDateAndTimeFormatter.stringFromDate(self)
    }
    
    public var iso8601DateAndTimeString: String {
        return NSDate.ISO8601SecondFormatter.stringFromDate(self)
    }
    
    public var iso8601MillisecondString: String {
        return NSDate.ISO8601MillisecondFormatter.stringFromDate(self)
    }
    
    public var iso8601DateString: String {
        return NSDate.ISO8601YearMonthDayFormatter.stringFromDate(self)
    }
    
    public var millisecondsSince1970: NSTimeInterval {
        return round(self.timeIntervalSince1970 * 1000)
    }
    
    public var dayAndMonthString: String {
        return NSDate.dayAndMonthFormatter.stringFromDate(self)
    }
    
    
    // MARK: - Helper computed vars
    
    public var isToday: Bool {
        let now = NSDate()
        let calender = NSCalendar.currentCalendar()
        let flags: NSCalendarUnit = [.Day, .Month, .Year]
        let componentsOne = calender.components(flags, fromDate: self)
        let componentsTwo = calender.components(flags, fromDate: now)
        return (componentsOne.day == componentsTwo.day && componentsOne.month == componentsTwo.month && componentsOne.year == componentsTwo.year)
    }
    
    public var startOfDay: NSDate {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Era, .Year, .Month, .Day], fromDate: self)
        let startOfDate = calendar.dateFromComponents(components)!
        return startOfDate
    }
    
    public var endOfDay: NSDate {
        let calendar = NSCalendar.currentCalendar()
        let nextDay = calendar.dateByAddingUnit(.Day, value: 1, toDate: self, options: [])!
        let components = calendar.components([.Era, .Year, .Month, .Day], fromDate: nextDay)
        let startOfDate = calendar.dateFromComponents(components)!
        return startOfDate
    }
    
    
    // MARK: - Functions
    
    public func rounded(by number: Int) -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Minute, fromDate: self)
        let extraMinutes = components.minute % number
        let rounded = round(Double(extraMinutes) / Double(number))
        let adjustedMinutes: Int
        if rounded == 0 {
            adjustedMinutes = -extraMinutes
        } else {
            adjustedMinutes = number - extraMinutes
        }
        components.minute = adjustedMinutes
        guard let roundedDate = calendar.dateByAddingComponents(components, toDate: self, options: []) else { return self }
        return roundedDate
    }
    
}


// MARK: - Comparable

extension NSDate: Comparable { }

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.timeIntervalSince1970 < rhs.timeIntervalSince1970
}
