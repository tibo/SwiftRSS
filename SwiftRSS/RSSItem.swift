//
//  RSSItem.swift
//  SwiftRSS_Example
//
//  Created by Thibaut LE LEVIER on 28/09/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit

public class RSSItem: NSObject, NSCoding {
    public var title: String?
    public var link: NSURL?
    
    public func setLink(let linkString: String!)
    {
        link = NSURL(string: linkString)
    }
    
    public var guid: String?
    public var pubDate: NSDate?
    
    public func setPubDate(let dateString: String!)
    {
        pubDate = NSDate.dateFromInternetDateTimeString(dateString)
    }
    
    public var itemDescription: String?
    public var content: String?
    
    // Wordpress specifics
    public var commentsLink: NSURL?
    
    public func setCommentsLink(let linkString: String!)
    {
        commentsLink = NSURL(string: linkString)
    }
    
    public var commentsCount: Int?
    
    public var commentRSSLink: NSURL?
    
    public func setCommentRSSLink(let linkString: String!)
    {
        commentRSSLink = NSURL(string: linkString)
    }
    
    public var author: String?
    
    public var categories: [String]! = [String]()
    
    public var imagesFromItemDescription: [NSURL]! {
        if let itemDescription = self.itemDescription
        {
            return itemDescription.imageLinksFromHTMLString
        }
        
        return [NSURL]()
    }
    
    public var imagesFromContent: [NSURL]! {
        if let content = self.content
        {
            return content.imageLinksFromHTMLString
        }
        
        return [NSURL]()
    }
    
    override public init()
    {
        super.init()
    }
    
    // MARK: NSCoding
    required public init(coder aDecoder: NSCoder)
    {
        super.init()
        
        title = aDecoder.decodeObjectForKey("title") as? String
        link = aDecoder.decodeObjectForKey("link") as? NSURL
        guid = aDecoder.decodeObjectForKey("guid") as? String
        pubDate = aDecoder.decodeObjectForKey("pubDate") as? NSDate
        itemDescription = aDecoder.decodeObjectForKey("description") as? String
        content = aDecoder.decodeObjectForKey("content") as? String
        commentsLink = aDecoder.decodeObjectForKey("commentsLink") as? NSURL
        commentsCount = aDecoder.decodeObjectForKey("commentsCount") as? Int
        commentRSSLink = aDecoder.decodeObjectForKey("commentRSSLink") as? NSURL
        author = aDecoder.decodeObjectForKey("author") as? String
        categories = aDecoder.decodeObjectForKey("categories") as? [String]
    }
    
    public func encodeWithCoder(aCoder: NSCoder)
    {
        if let title = self.title
        {
            aCoder.encodeObject(title, forKey: "title")
        }
        
        if let link = self.link
        {
            aCoder.encodeObject(link, forKey: "link")
        }
        
        if let guid = self.guid
        {
            aCoder.encodeObject(guid, forKey: "guid")
        }
        
        if let pubDate = self.pubDate
        {
            aCoder.encodeObject(pubDate, forKey: "pubDate")
        }
        
        if let itemDescription = self.itemDescription
        {
            aCoder.encodeObject(itemDescription, forKey: "description")
        }
        
        if let content = self.content
        {
            aCoder.encodeObject(content, forKey: "content")
        }
        
        if let commentsLink = self.commentsLink
        {
            aCoder.encodeObject(commentsLink, forKey: "commentsLink")
        }
        
        if let commentsCount = self.commentsCount
        {
            aCoder.encodeObject(commentsCount, forKey: "commentsCount")
        }
        
        if let commentRSSLink = self.commentRSSLink
        {
            aCoder.encodeObject(commentRSSLink, forKey: "commentRSSLink")
        }
        
        if let author = self.author
        {
            aCoder.encodeObject(author, forKey: "author")
        }
        
        aCoder.encodeObject(categories, forKey: "categories")
    }
}