/*
 |  _   ____   ____   _
 | ⎛ |‾|  ⚈ |-| ⚈  |‾| ⎞
 | ⎝ |  ‾‾‾‾| |‾‾‾‾  | ⎠
 |  ‾        ‾        ‾
 */

import Foundation

extension NSDate {
    
    // MARK: - Formatters
    
    static private var ISO8601MillisecondFormatter: NSDateFormatter {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let tz = NSTimeZone(abbreviation:"GMT")
        formatter.timeZone = tz
        return formatter
    }
    
    static private var ISO8601SecondFormatter: NSDateFormatter {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let tz = NSTimeZone(abbreviation:"GMT")
        formatter.timeZone = tz
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
    
    static private var dayAndMonthFormatter: NSDateFormatter {
        let formatter = NSDateFormatter()
        formatter.dateFormat = NSDateFormatter.dateFormatFromTemplate("MMM d", options: 0, locale: NSLocale.currentLocale())
        return formatter
    }
    
    static private let parsingFormatters = [ISO8601MillisecondFormatter, ISO8601SecondFormatter, ISO8601YearMonthDayFormatter]
    
    static func fromISO8601String(dateString:String) -> NSDate? {
        for formatter in parsingFormatters {
            if let date = formatter.dateFromString(dateString) {
                return date
            }
        }
        return .None
    }
    
    static func fromMillisecondsSince1970(milliseconds: Double) -> NSDate {
        let dateSeconds = milliseconds / 1000.0
        let dateInterval = NSTimeInterval(dateSeconds)
        let date = NSDate(timeIntervalSince1970: dateInterval)
        return date
    }
    
    
    // MARK: - Formatted computed vars
    
    var dateAndTimeString: String {
        return NSDate.dateAndTimeFormatter.stringFromDate(self)
    }
    
    var iso8601DateAndTimeString: String {
        return NSDate.ISO8601SecondFormatter.stringFromDate(self)
    }
    
    var iso8601MillisecondString: String {
        return NSDate.ISO8601MillisecondFormatter.stringFromDate(self)
    }
    
    var iso8601DateString: String {
        return NSDate.ISO8601YearMonthDayFormatter.stringFromDate(self)
    }
    
    var millisecondsSince1970: NSTimeInterval {
        return round(self.timeIntervalSince1970 * 1000)
    }
    
    var dayAndMonthString: String {
        return NSDate.dayAndMonthFormatter.stringFromDate(self)
    }
    
    
    // MARK: - Helper computed vars
    
    var isToday: Bool {
        let now = NSDate()
        let calender = NSCalendar.currentCalendar()
        let flags: NSCalendarUnit = [.Day, .Month, .Year]
        let componentsOne = calender.components(flags, fromDate: self)
        let componentsTwo = calender.components(flags, fromDate: now)
        return (componentsOne.day == componentsTwo.day && componentsOne.month == componentsTwo.month && componentsOne.year == componentsTwo.year)
    }
    
    var startOfDay: NSDate {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Era, .Year, .Month, .Day], fromDate: self)
        let startOfDate = calendar.dateFromComponents(components)!
        return startOfDate
    }
    
    var endOfDay: NSDate {
        let calendar = NSCalendar.currentCalendar()
        let nextDay = calendar.dateByAddingUnit(.Day, value: 1, toDate: self, options: [])!
        let components = calendar.components([.Era, .Year, .Month, .Day], fromDate: nextDay)
        let startOfDate = calendar.dateFromComponents(components)!
        return startOfDate
    }
    
}
