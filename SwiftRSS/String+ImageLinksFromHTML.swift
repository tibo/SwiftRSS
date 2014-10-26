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
        
        var error: NSError
        
        if let regex = NSRegularExpression(pattern:"(https?)\\S*(png|jpg|jpeg|gif)", options:.CaseInsensitive, error:nil)
        {
            regex.enumerateMatchesInString(self, options: NSMatchingOptions(0), range: NSRange(location: 0, length: self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))) {
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
