//
//  RSSItem.swift
//  SwiftRSS_Example
//
//  Created by Thibaut LE LEVIER on 28/09/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit

class RSSItem: NSObject {
    var title: String?
    var link: NSURL?
    var guid: String?
    var pubDate: NSDate?
    var itemDescription: String?
    var content: String?
    
    func setLink(let linkString: String)
    {
        self.link = NSURL(string: linkString)
    }
    
    func setPubDate(let dateString: String)
    {
        pubDate = NSDate.dateFromInternetDateTimeString(dateString)
    }
}