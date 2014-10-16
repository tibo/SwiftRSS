//
//  RSSFeedMeta.swift
//  SwiftRSS_Example
//
//  Created by Thibaut LE LEVIER on 05/10/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit

class RSSFeed: NSObject {
    
    var items: [RSSItem]! = [RSSItem]()
    
    var title: String?
    var link: NSURL?
    var feedDescription: String?
    var language: String?
    var lastBuildDate: NSDate?
    var generator: String?
    var copyright: String?
    
    func setLink(let linkString: String)
    {
        link = NSURL(string: linkString)
    }
    
    func setlastBuildDate(let dateString: String)
    {
        lastBuildDate = NSDate.dateFromInternetDateTimeString(dateString)
    }
    
}
