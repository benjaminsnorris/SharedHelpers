//
//  NSDate+HelpersSpec.swift
//  align
//
//  Created by Ben Norris on 5/10/16.
//  Copyright © 2016 OC Tanner. All rights reserved.
//

//import Foundation
//import Quick
//import Nimble
//import Marshal
//@testable import align
//
//class NSDateHelpersSpec: QuickSpec {
//    
//    override func spec() {
//        
//        describe("NSDate+Helpers") {
//
//            let millisecondDateString = "2016-01-01T12:34:56.789+0000"
//            let secondDateString = "2016-01-01T12:34:56+0000"
//            let dateString = "2016-01-01"
//            let dateAndTimeString = "Jan 1, 2016, 5:34 AM"
//            
//            describe("Date string formats") {
//                
//                it("should properly format a date to ISO 8601 with milliseconds") {
//                    let date = NSDate.fromISO8601String(millisecondDateString)
//                    expect(date?.iso8601MillisecondString) == millisecondDateString
//                    expect(date?.iso8601DateAndTimeString) == secondDateString
//                    expect(date?.iso8601DateString) == dateString
//                }
//                
//                it("should properly format a date to ISO 8601 with seconds") {
//                    let date = NSDate.fromISO8601String(secondDateString)
//                    expect(date?.iso8601DateAndTimeString) == secondDateString
//                    expect(date?.iso8601DateString) == dateString
//                }
//                
//                it("should properly format a date to ISO 8601 with a date") {
//                    let date = NSDate.fromISO8601String(dateString)
//                    expect(date?.iso8601DateString) == dateString
//                }
//                
//                it("should properly format a date to a custom format in the current time zone") {
//                    let date = NSDate.fromISO8601String(secondDateString)
//                    expect(date?.dateAndTimeString) == dateAndTimeString
//                }
//
//            }
//            
//            describe("Other date helpers") {
//                
//                it("should properly identify now as today") {
//                    let now = NSDate()
//                    expect(now.isToday) == true
//                }
//                
//                it("should verify that 25 hours ago is not today") {
//                    let now = NSDate()
//                    let yesterday = now.dateByAddingTimeInterval(-25 * 60 * 60)
//                    expect(yesterday.isToday) == false
//                    expect(now.startOfDay > yesterday) == true
//                }
//                
//                it("should verify that 25 hours in the future is not today") {
//                    let now = NSDate()
//                    let tomorrow = now.dateByAddingTimeInterval(25 * 60 * 60)
//                    expect(tomorrow.isToday) == false
//                    expect(now.endOfDay < tomorrow) == true
//                }
//                
//                it("should provide the start of day occurring today and before now") {
//                    let now = NSDate()
//                    let startOfToday = now.startOfDay
//                    expect(startOfToday.isToday) == true
//                    expect(now > startOfToday) == true
//                }
//                
//                it("should provide the end of date occuring at the beginning of the next day and after now") {
//                    let now = NSDate()
//                    let endOfToday = now.endOfDay
//                    expect(endOfToday.isToday) == false
//                    expect(now < endOfToday) == true
//                }
//                
//            }
//            
//        }
//
//    }
//
//}
