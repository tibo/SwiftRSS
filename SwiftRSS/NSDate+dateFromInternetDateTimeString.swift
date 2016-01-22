//
//  NSDateExtension.swift
//  SwiftRSS_Example
//
//  Created by Thibaut LE LEVIER on 01/10/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

// This extension handle date from string in the following formats:
// - RFC822 (See http://www.faqs.org/rfcs/rfc822.html )
// - RFC3339 (See http://www.faqs.org/rfcs/rfc3339.html )
// The following code take a lot of inspiration from Michael Waterfall date category in MWFeedParser
// Thanks to him!


import UIKit

extension NSDate {
    
    class var internetDateFormatter : NSDateFormatter {
    struct Static {
        static let instance: NSDateFormatter = {
            let dateFormatter = NSDateFormatter()
            let locale: NSLocale = NSLocale(localeIdentifier: "en_US_POSIX")
            dateFormatter.locale = locale
            dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
            return dateFormatter
            }()
        }
        return Static.instance
    }
    
    class func dateFromInternetDateTimeString(dateString: String!) -> NSDate?
    {
        var date: NSDate? = nil
        
        date = NSDate.dateFromRFC822String(dateString)
        
        if date == nil
        {
            date = NSDate.dateFromRFC3339String(dateString)
        }
        
        return date
    }
    
    class func dateFromRFC822String(dateString: String!) -> NSDate?
    {
        var date: NSDate? = nil
        
        let rfc822_string: NSString = dateString.uppercaseString
        
        if rfc822_string.rangeOfString(",").location != NSNotFound
        {
            if date == nil
            {
                NSDate.internetDateFormatter.dateFormat = "EEE, d MMM yyyy HH:mm:ss zzz"
                
                date = NSDate.internetDateFormatter.dateFromString(rfc822_string as String)
            }
            
            if date == nil
            {
                NSDate.internetDateFormatter.dateFormat = "EEE, d MMM yyyy HH:mm zzz"
                
                date = NSDate.internetDateFormatter.dateFromString(rfc822_string as String)
            }
            
            if date == nil
            {
                NSDate.internetDateFormatter.dateFormat = "EEE, d MMM yyyy HH:mm:ss"

                date = NSDate.internetDateFormatter.dateFromString(rfc822_string as String)
            }
            
            if date == nil
            {
                NSDate.internetDateFormatter.dateFormat = "EEE, d MMM yyyy HH:mm"
                
                date = NSDate.internetDateFormatter.dateFromString(rfc822_string as String)
            }
        }
        else
        {
            if date == nil
            {
                NSDate.internetDateFormatter.dateFormat = "d MMM yyyy HH:mm:ss zzz"
                
                date = NSDate.internetDateFormatter.dateFromString(rfc822_string as String)
            }
            
            if date == nil
            {
                NSDate.internetDateFormatter.dateFormat = "d MMM yyyy HH:mm zzz"
                                
                date = NSDate.internetDateFormatter.dateFromString(rfc822_string as String)
            }
            
            if date == nil
            {
                NSDate.internetDateFormatter.dateFormat = "d MMM yyyy HH:mm:ss"
                
                date = NSDate.internetDateFormatter.dateFromString(rfc822_string as String)
            }
            
            if date == nil
            {
                NSDate.internetDateFormatter.dateFormat = "d MMM yyyy HH:mm"
                
                date = NSDate.internetDateFormatter.dateFromString(rfc822_string as String)
            }
        }
        
        if date == nil
        {
            NSLog("unable to parse RFC822 date \(dateString)")
        }
        
        return date
    }
    
    class func dateFromRFC3339String(dateString: String!) -> NSDate?
    {
        var date: NSDate? = nil
        
        var rfc3339_string: NSString = dateString.uppercaseString
        
        if rfc3339_string.length > 20
        {
            rfc3339_string = rfc3339_string.stringByReplacingOccurrencesOfString(":", withString: "", options: .CaseInsensitiveSearch, range: NSMakeRange(20, rfc3339_string.length-20))
        }
        
        if date == nil
        {
            NSDate.internetDateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
            
            date = NSDate.internetDateFormatter.dateFromString(rfc3339_string as String)
        }
        
        if date == nil // this case may need more work
        {
            NSDate.internetDateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZZZ"
            
            date = NSDate.internetDateFormatter.dateFromString(rfc3339_string as String)
        }
        
        if date == nil
        {
            NSDate.internetDateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss"
            
            date = NSDate.internetDateFormatter.dateFromString(rfc3339_string as String)
        }
        
        if date == nil
        {
            NSLog("unable to parse RFC3339 date \(dateString)")
        }
        
        return date
    }
   
}
