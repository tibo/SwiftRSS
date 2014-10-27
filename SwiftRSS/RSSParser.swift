//
//  RSSParser.swift
//  SwiftRSS_Example
//
//  Created by Thibaut LE LEVIER on 05/09/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit

class RSSParser: NSObject, NSXMLParserDelegate {
    
    class func parseFeedForRequest(request: NSURLRequest, callback: (feed: RSSFeed?, error: NSError?) -> Void)
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
    
    func parseFeedForRequest(request: NSURLRequest, callback: (feed: RSSFeed?, error: NSError?) -> Void)
    {
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in

            if ((error) != nil)
            {
                callback(feed: nil, error: error)
            }
            else
            {
                self.callbackClosure = callback
                
                var parser : NSXMLParser = NSXMLParser(data: data)
                parser.delegate = self
                parser.shouldResolveExternalEntities = false
                parser.parse()
            }
        }
    }
    
// MARK: NSXMLParserDelegate
    func parserDidStartDocument(parser: NSXMLParser)
    {
    }
    
    func parserDidEndDocument(parser: NSXMLParser)
    {
        if let closure = self.callbackClosure?
        {
            closure(feed: self.feed, error: nil)
        }
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        
        if elementName == node_item
        {
            self.currentItem = RSSItem()
        }
        
        self.currentElement = ""
        
    }
   
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == node_item
        {
            if let item = self.currentItem?
            {
                self.feed.items.append(item)
            }
            
            self.currentItem = nil
            return
        }
        
        if let item = self.currentItem?
        {
            if elementName == node_title
            {
                item.title = self.currentElement
            }
            
            if elementName == node_link
            {
                item.setLink(self.currentElement)
            }
            
            if elementName == node_guid
            {
                item.guid = self.currentElement
            }
            
            if elementName == node_publicationDate
            {
                item.setPubDate(self.currentElement)
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
                item.setCommentsLink(self.currentElement)
            }
            
            if elementName == node_commentsCount
            {
                item.commentsCount = self.currentElement.toInt()
            }
            
            if elementName == node_commentRSSLink
            {
                item.setCommentRSSLink(self.currentElement)
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
                feed.setLink(self.currentElement)
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
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        self.currentElement += string
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        
        if let closure = self.callbackClosure?
        {
            closure(feed: nil, error: parseError)
        }
    }

}