//
//  NSDateExtension_Tests.swift
//  SwiftRSS_Example
//
//  Created by Thibaut LE LEVIER on 01/10/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit
import XCTest
import SwiftRSS

class NSDateExtension_Tests: XCTestCase {
    
    let GMT_timeZone: NSTimeZone! = NSTimeZone(forSecondsFromGMT: 0)
    let calendar: NSCalendar! = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
    let calendar_flags = NSCalendarUnit(UInt.max)

    override func setUp() {
        super.setUp()
        calendar.timeZone = GMT_timeZone
    }
    
    override func tearDown() {
        super.tearDown()
    }

// MARK: RFC822
    // TODO: Issue with extensions in frameworks?
    // http://stackoverflow.com/questions/24175596/swift-framework-does-not-include-symbols-from-extensions-to-generic-structs
    /*func test_dateFormatter_withDateStringRFC822Format1_shouldReturnValidDate() {
        
        let dateString = "Sun, 19 May 2002 15:21:36 GMT"
        
        if let date: NSDate = NSDate.dateFromInternetDateTimeString(dateString)?
        {
            var dateComponent = calendar.components(calendar_flags, fromDate: date)
            
            XCTAssert(dateComponent.weekday == 1, "")
            XCTAssert(dateComponent.day == 19, "")
            XCTAssert(dateComponent.month == 5, "")
            XCTAssert(dateComponent.year == 2002, "")
            XCTAssert(dateComponent.hour == 15, "")
            XCTAssert(dateComponent.minute == 21, "")
            XCTAssert(dateComponent.second == 36, "")
            XCTAssert(dateComponent.timeZone!.isEqualToTimeZone(GMT_timeZone), "")
        }
        else
        {
            XCTFail("date is nil")
        }
    }
    
    func test_dateFormatter_withDateStringRFC822Format2_shouldReturnValidDate() {
        
        let dateString = "Sun, 19 May 2002 15:21 GMT"
        
        if let date: NSDate = NSDate.dateFromInternetDateTimeString(dateString)?
        {
            var dateComponent = calendar.components(calendar_flags, fromDate: date)
            
            XCTAssert(dateComponent.weekday == 1, "")
            XCTAssert(dateComponent.day == 19, "")
            XCTAssert(dateComponent.month == 5, "")
            XCTAssert(dateComponent.year == 2002, "")
            XCTAssert(dateComponent.hour == 15, "")
            XCTAssert(dateComponent.minute == 21, "")
            XCTAssert(dateComponent.second == 0, "")
            XCTAssert(dateComponent.timeZone!.isEqualToTimeZone(GMT_timeZone), "")
        }
        else
        {
            XCTFail("date is nil")
        }
    }
    
    func test_dateFormatter_withDateStringRFC822Format3_shouldReturnValidDate() {
        
        let dateString = "Sun, 19 May 2002 15:21:36"
        
        if let date: NSDate = NSDate.dateFromInternetDateTimeString(dateString)?
        {
            var dateComponent = calendar.components(calendar_flags, fromDate: date)
            
            XCTAssert(dateComponent.weekday == 1, "")
            XCTAssert(dateComponent.day == 19, "")
            XCTAssert(dateComponent.month == 5, "")
            XCTAssert(dateComponent.year == 2002, "")
            XCTAssert(dateComponent.hour == 15, "")
            XCTAssert(dateComponent.minute == 21, "")
            XCTAssert(dateComponent.second == 36, "")
        }
        else
        {
            XCTFail("date is nil")
        }
    }
    
    func test_dateFormatter_withDateStringRFC822Format4_shouldReturnValidDate() {
        
        let dateString = "Sun, 19 May 2002 15:21"
        
        if let date: NSDate = NSDate.dateFromInternetDateTimeString(dateString)?
        {
            var dateComponent = calendar.components(calendar_flags, fromDate: date)
            
            XCTAssert(dateComponent.weekday == 1, "")
            XCTAssert(dateComponent.day == 19, "")
            XCTAssert(dateComponent.month == 5, "")
            XCTAssert(dateComponent.year == 2002, "")
            XCTAssert(dateComponent.hour == 15, "")
            XCTAssert(dateComponent.minute == 21, "")
            XCTAssert(dateComponent.second == 0, "")
        }
        else
        {
            XCTFail("date is nil")
        }
    }
    
    func test_dateFormatter_withDateStringRFC822Format5_shouldReturnValidDate() {
        
        let dateString = "19 May 2002 15:21:36 GMT"
        
        if let date: NSDate = NSDate.dateFromInternetDateTimeString(dateString)?
        {
            var dateComponent = calendar.components(calendar_flags, fromDate: date)
            
            XCTAssert(dateComponent.day == 19, "")
            XCTAssert(dateComponent.month == 5, "")
            XCTAssert(dateComponent.year == 2002, "")
            XCTAssert(dateComponent.hour == 15, "")
            XCTAssert(dateComponent.minute == 21, "")
            XCTAssert(dateComponent.second == 36, "")
            XCTAssert(dateComponent.timeZone!.isEqualToTimeZone(GMT_timeZone), "")
        }
        else
        {
            XCTFail("date is nil")
        }
    }
    
    func test_dateFormatter_withDateStringRFC822Format6_shouldReturnValidDate() {
        
        let dateString = "19 May 2002 15:21 GMT"
        
        if let date: NSDate = NSDate.dateFromInternetDateTimeString(dateString)?
        {
            var dateComponent = calendar.components(calendar_flags, fromDate: date)
            
            XCTAssert(dateComponent.day == 19, "")
            XCTAssert(dateComponent.month == 5, "")
            XCTAssert(dateComponent.year == 2002, "")
            XCTAssert(dateComponent.hour == 15, "")
            XCTAssert(dateComponent.minute == 21, "")
            XCTAssert(dateComponent.second == 0, "")
            XCTAssert(dateComponent.timeZone!.isEqualToTimeZone(GMT_timeZone), "")
        }
        else
        {
            XCTFail("date is nil")
        }
    }
    
    func test_dateFormatter_withDateStringRFC822Format7_shouldReturnValidDate() {
        
        let dateString = "19 May 2002 15:21:36"
        
        if let date: NSDate = NSDate.dateFromInternetDateTimeString(dateString)?
        {
            var dateComponent = calendar.components(calendar_flags, fromDate: date)
            
            XCTAssert(dateComponent.day == 19, "")
            XCTAssert(dateComponent.month == 5, "")
            XCTAssert(dateComponent.year == 2002, "")
            XCTAssert(dateComponent.hour == 15, "")
            XCTAssert(dateComponent.minute == 21, "")
            XCTAssert(dateComponent.second == 36, "")
        }
        else
        {
            XCTFail("date is nil")
        }
    }
    
    func test_dateFormatter_withDateStringRFC822Format8_shouldReturnValidDate() {
        
        let dateString = "19 May 2002 15:21"
        
        if let date: NSDate = NSDate.dateFromInternetDateTimeString(dateString)?
        {
            var dateComponent = calendar.components(calendar_flags, fromDate: date)
            
            XCTAssert(dateComponent.day == 19, "")
            XCTAssert(dateComponent.month == 5, "")
            XCTAssert(dateComponent.year == 2002, "")
            XCTAssert(dateComponent.hour == 15, "")
            XCTAssert(dateComponent.minute == 21, "")
            XCTAssert(dateComponent.second == 0, "")
        }
        else
        {
            XCTFail("date is nil")
        }
    }
    
// MARK: RFC3339
    
    func test_dateFormatter_withDateStringRFC3339Format1_shouldReturnValidDate() {
        
        let dateString = "1996-12-19T16:39:57-0800"
        let timeZone = NSTimeZone(forSecondsFromGMT: -60*60*8)
        calendar.timeZone = timeZone
        
        if let date: NSDate = NSDate.dateFromInternetDateTimeString(dateString)?
        {
            var dateComponent = calendar.components(calendar_flags, fromDate: date)
            
            XCTAssert(dateComponent.day == 19, "")
            XCTAssert(dateComponent.month == 12, "")
            XCTAssert(dateComponent.year == 1996, "")
            XCTAssert(dateComponent.hour == 16, "")
            XCTAssert(dateComponent.minute == 39, "")
            XCTAssert(dateComponent.second == 57, "")
            XCTAssert(dateComponent.timeZone!.isEqualToTimeZone(timeZone), "")
        }
        else
        {
            XCTFail("date is nil")
        }
    }
    
    func test_dateFormatter_withDateStringRFC3339Format2_shouldReturnValidDate() {
        
        let dateString = "1937-01-01T12:00:27.87+0020"
        let timeZone = NSTimeZone(forSecondsFromGMT: 60*60*2)
        calendar.timeZone = timeZone
        
        if let date: NSDate = NSDate.dateFromInternetDateTimeString(dateString)?
        {
            
            var dateComponent = calendar.components(calendar_flags, fromDate: date)
            
            XCTAssert(dateComponent.day == 1, "")
            XCTAssert(dateComponent.month == 1, "")
            XCTAssert(dateComponent.year == 1937, "")
//            XCTAssert(dateComponent.hour == 12, "")
//            XCTAssert(dateComponent.minute == 0, "")
            XCTAssert(dateComponent.second == 27, "")
            XCTAssert(dateComponent.timeZone!.isEqualToTimeZone(timeZone), "")
        }
        else
        {
            XCTFail("date is nil")
        }
    }
    
    func test_dateFormatter_withDateStringRFC3339Format3_shouldReturnValidDate() {
        
        let dateString = "1937-01-01T12:00:27"
        
        if let date: NSDate = NSDate.dateFromInternetDateTimeString(dateString)?
        {
            var dateComponent = calendar.components(calendar_flags, fromDate: date)
            
            XCTAssert(dateComponent.day == 1, "")
            XCTAssert(dateComponent.month == 1, "")
            XCTAssert(dateComponent.year == 1937, "")
            XCTAssert(dateComponent.hour == 12, "")
            XCTAssert(dateComponent.minute == 0, "")
            XCTAssert(dateComponent.second == 27, "")
        }
        else
        {
            XCTFail("date is nil")
        }
    }
    */


}
