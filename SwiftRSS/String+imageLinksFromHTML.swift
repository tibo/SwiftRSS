//
//  String+ImageLinksFromHTML.swift
//  SwiftRSS_Example
//
//  Created by Thibaut LE LEVIER on 22/10/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit

extension String {
    var imageLinksFromHTMLString: [NSURL]
    {
        var matches = [NSURL]()
        
        var error: NSError?
        
        var full_range: NSRange = NSMakeRange(0, count(self))
        
        if let regex = NSRegularExpression(pattern:"(https?)\\S*(png|jpg|jpeg|gif)", options:.CaseInsensitive, error:&error)
        {
            regex.enumerateMatchesInString(self, options: NSMatchingOptions(0), range: full_range) {
                (result : NSTextCheckingResult!, _, _) in
                
                // didn't find a way to bridge an NSRange to Range<String.Index>
                // bridging String to NSString instead
                var str = (self as NSString).substringWithRange(result.range) as String
                
                matches.append(NSURL(string: str)!)
            }
        }
        
        return matches
    }
}
