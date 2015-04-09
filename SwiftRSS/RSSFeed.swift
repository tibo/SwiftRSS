//
//  RSSFeedMeta.swift
//  SwiftRSS_Example
//
//  Created by Thibaut LE LEVIER on 05/10/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit

class RSSFeed: NSObject, NSCoding {
    
    var items: [RSSItem]! = [RSSItem]()
    
    var title: String?
    var link: NSURL?
    
    func setLink(let linkString: String!)
    {
        link = NSURL(string: linkString)
    }
    
    var feedDescription: String?
    var language: String?
    var lastBuildDate: NSDate?
    
    func setlastBuildDate(let dateString: String!)
    {
        lastBuildDate = NSDate.dateFromInternetDateTimeString(dateString)
    }
    
    var generator: String?
    var copyright: String?
    
    
    override init()
    {
        super.init()
    }
    
    // MARK: NSCoding
    required init(coder aDecoder: NSCoder)
    {
        super.init()
        
        title = aDecoder.decodeObjectForKey("title") as? String
        link = aDecoder.decodeObjectForKey("link") as? NSURL
        feedDescription = aDecoder.decodeObjectForKey("description") as? String
        language = aDecoder.decodeObjectForKey("language") as? String
        lastBuildDate = aDecoder.decodeObjectForKey("lastBuildDate") as? NSDate
        generator = aDecoder.decodeObjectForKey("generator") as? String
        copyright = aDecoder.decodeObjectForKey("copyright") as? String
        
        items = aDecoder.decodeObjectForKey("items") as! [RSSItem]
    }
    
    func encodeWithCoder(aCoder: NSCoder)
    {
        if let title = self.title
        {
            aCoder.encodeObject(title, forKey: "title")
        }
        
        if let link = self.link
        {
            aCoder.encodeObject(link, forKey: "link")
        }
        
        if let feedDescription = self.feedDescription
        {
            aCoder.encodeObject(feedDescription, forKey: "description")
        }
        
        if let language = self.language
        {
            aCoder.encodeObject(language, forKey: "language")
        }
        
        if let lastBuildDate = self.lastBuildDate
        {
            aCoder.encodeObject(lastBuildDate, forKey: "lastBuildDate")
        }
        
        if let generator = self.generator
        {
            aCoder.encodeObject(generator, forKey: "generator")
        }
        
        
        if let copyright = self.copyright
        {
            aCoder.encodeObject(copyright, forKey: "copyright")
        }
        
        aCoder.encodeObject(self.items, forKey: "items")
    }
    
}
