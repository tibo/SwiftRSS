//
//  RSSParser.swift
//  SwiftRSS_Example
//
//  Created by Thibaut LE LEVIER on 05/09/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit

class RSSParser: NSObject, NSXMLParserDelegate {
    
    class func parseFeedForRequest(request: NSURLRequest, callback: (feedMeta: RSSFeedMeta?, items: [RSSItem]?, error: NSError?) -> Void)
    {
        let rssParser: RSSParser = RSSParser()
        
        rssParser.parseFeedForRequest(request, callback: callback)
    }
    
    var callbackClosure: ((feedMeta: RSSFeedMeta?, items: [RSSItem]?, error: NSError?) -> Void)?
    var currentElement: String = ""
    var currentItem: RSSItem?
    var items: NSMutableArray! = NSMutableArray()
    var feedMeta: RSSFeedMeta = RSSFeedMeta()
    
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
    
    func parseFeedForRequest(request: NSURLRequest, callback: (feedMeta: RSSFeedMeta?, items: [RSSItem]?, error: NSError?) -> Void)
    {
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in

            if ((error) != nil)
            {
                callback(feedMeta: nil, items: nil, error: error)
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
        self.callbackClosure!(feedMeta: feedMeta, items: items as AnyObject as? [RSSItem] ,error: nil)
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        
        NSLog("begin \(elementName)")
        
        if elementName == node_item
        {
            self.currentItem = RSSItem()
        }
        
        currentElement = ""
        
    }
   
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        NSLog("end \(elementName)")
        
        if elementName == node_item
        {
            items.addObject(self.currentItem!)
            self.currentItem = nil
            return
        }
        
        NSLog("end element \(elementName) = \(currentElement)")
        
        if let item = currentItem?
        {
            if elementName == node_title
            {
                item.title = currentElement
            }
            
            if elementName == node_link
            {
                item.setLink(currentElement)
            }
            
            if elementName == node_guid
            {
                item.guid = currentElement
            }
            
            if elementName == node_publicationDate
            {
                item.setPubDate(currentElement)
            }
            
            if elementName == node_description
            {
                item.itemDescription = currentElement
            }
            
            if elementName == node_content
            {
                item.content = currentElement
            }
        }
        else
        {
            if elementName == node_title
            {
                feedMeta.title = currentElement
            }
            
            if elementName == node_link
            {
                feedMeta.setLink(currentElement)
            }
            
            if elementName == node_description
            {
                feedMeta.feedDescription = currentElement
            }
            
            if elementName == node_language
            {
                feedMeta.language = currentElement
            }
            
            if elementName == node_lastBuildDate
            {
                feedMeta.setlastBuildDate(currentElement)
            }
            
            if elementName == node_generator
            {
                feedMeta.generator = currentElement
            }
            
            if elementName == node_copyright
            {
                feedMeta.copyright = currentElement
            }
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        currentElement += string
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        
        NSLog("parsing error: \(parseError)")
        
        self.callbackClosure!(feedMeta: nil, items: nil ,error: parseError)
    }

}