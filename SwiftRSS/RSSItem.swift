//
//  RSSItem.swift
//  SwiftRSS_Example
//
//  Created by Thibaut LE LEVIER on 28/09/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit

class RSSItem: NSObject, NSCoding {
    var title: String?
    var link: NSURL?
    var guid: String?
    var pubDate: NSDate?
    var itemDescription: String?
    var content: String?
    
    func setLink(let linkString: String)
    {
        link = NSURL(string: linkString)
    }
    
    func setPubDate(let dateString: String)
    {
        pubDate = NSDate.dateFromInternetDateTimeString(dateString)
    }
    
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
        guid = aDecoder.decodeObjectForKey("guid") as? String
        pubDate = aDecoder.decodeObjectForKey("pubDate") as? NSDate
        itemDescription = aDecoder.decodeObjectForKey("description") as? NSString
        content = aDecoder.decodeObjectForKey("content") as? NSString
        
    }
    
    func encodeWithCoder(aCoder: NSCoder)
    {
        if let title = self.title?
        {
            aCoder.encodeObject(title, forKey: "title")
        }
        
        if let link = self.link?
        {
            aCoder.encodeObject(link, forKey: "link")
        }
        
        if let guid = self.guid?
        {
            aCoder.encodeObject(guid, forKey: "guid")
        }
        
        if let pubDate = self.pubDate?
        {
            aCoder.encodeObject(self.pubDate!, forKey: "pubDate")
        }
        
        if let itemDescription = self.itemDescription?
        {
            aCoder.encodeObject(self.itemDescription!, forKey: "description")
        }
        
        if let content = self.content?
        {
            aCoder.encodeObject(self.content!, forKey: "content")
        }
    }
}