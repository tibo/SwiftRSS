//
//  RSSParser.swift
//  SwiftRSS_Example
//
//  Created by Thibaut LE LEVIER on 05/09/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit

public class RSSParser: NSObject, NSXMLParserDelegate {
    
    public class func parseFeedForRequest(request: NSURLRequest, callback: (feed: RSSFeed?, error: NSError?) -> Void)
    {
        let rssParser: RSSParser = RSSParser()
        
        rssParser.parseFeedForRequest(request, callback: callback)
    }
    
    var callbackClosure: ((feed: RSSFeed?, error: NSError?) -> Void)?
    var currentElement: String = ""
    var currentItem: RSSItem?
    var feed: RSSFeed = RSSFeed()
    
    // node names
    let node_item: String = "item"
    
    let node_title: String = "title"
    let node_link: String = "link"
    let node_guid: String = "guid"
    let node_publicationDate: String = "pubDate"
    let node_description: String = "description"
    let node_content: String = "content:encoded"
    let node_language: String = "language"
    let node_lastBuildDate = "lastBuildDate"
    let node_generator = "generator"
    let node_copyright = "copyright"
    // wordpress specifics
    let node_commentsLink = "comments"
    let node_commentsCount = "slash:comments"
    let node_commentRSSLink = "wfw:commentRss"
    let node_author = "dc:creator"
    let node_category = "category"
    
    public func parseFeedForRequest(request: NSURLRequest, callback: (feed: RSSFeed?, error: NSError?) -> Void)
    {
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in

            if ((error) != nil)
            {
                callback(feed: nil, error: error)
            }
            else
            {
                self.callbackClosure = callback
                
                let parser : NSXMLParser = NSXMLParser(data: data!)
                parser.delegate = self
                parser.shouldResolveExternalEntities = false
                parser.parse()
            }
        }
    }
    
// MARK: NSXMLParserDelegate
    public func parserDidStartDocument(parser: NSXMLParser)
    {
    }
    
    public func parserDidEndDocument(parser: NSXMLParser)
    {
        if let closure = self.callbackClosure
        {
            closure(feed: self.feed, error: nil)
        }
    }
    
    public func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        if elementName == node_item
        {
            self.currentItem = RSSItem()
        }
        
        self.currentElement = ""
        
    }
   
    public func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == node_item
        {
            if let item = self.currentItem
            {
                self.feed.items.append(item)
            }
            
            self.currentItem = nil
            return
        }
        
        if let item = self.currentItem
        {
            if elementName == node_title
            {
                item.title = self.currentElement
            }
            
            if elementName == node_link
            {
                item.setLinkAsString(self.currentElement)
            }
            
            if elementName == node_guid
            {
                item.guid = self.currentElement
            }
            
            if elementName == node_publicationDate
            {
                item.setPubDateAsString(self.currentElement)
            }
            
            if elementName == node_description
            {
                item.itemDescription = self.currentElement
            }
            
            if elementName == node_content
            {
                item.content = self.currentElement
            }
            
            if elementName == node_commentsLink
            {
                item.setCommentsLinkAsString(self.currentElement)
            }
            
            if elementName == node_commentsCount
            {
                item.commentsCount = Int(self.currentElement)
            }
            
            if elementName == node_commentRSSLink
            {
                item.setCommentRSSLinkAsString(self.currentElement)
            }
            
            if elementName == node_author
            {
                item.author = self.currentElement
            }
            
            if elementName == node_category
            {
                item.categories.append(self.currentElement)
            }
            
        }
        else
        {
            if elementName == node_title
            {
                feed.title = self.currentElement
            }
            
            if elementName == node_link
            {
                feed.setLinkAsSTring(self.currentElement)
            }
            
            if elementName == node_description
            {
                feed.feedDescription = self.currentElement
            }
            
            if elementName == node_language
            {
                feed.language = self.currentElement
            }
            
            if elementName == node_lastBuildDate
            {
                feed.setlastBuildDate(self.currentElement)
            }
            
            if elementName == node_generator
            {
                feed.generator = self.currentElement
            }
            
            if elementName == node_copyright
            {
                feed.copyright = self.currentElement
            }
        }
    }
    
    public func parser(parser: NSXMLParser, foundCharacters string: String) {
        self.currentElement += string
    }
    
    public func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        
        if let closure = self.callbackClosure
        {
            closure(feed: nil, error: parseError)
        }
    }

}