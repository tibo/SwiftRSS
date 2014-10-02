//
//  RSSParser.swift
//  SwiftRSS_Example
//
//  Created by Thibaut LE LEVIER on 05/09/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit

class RSSParser: NSObject, NSXMLParserDelegate {
    
    class func parseFeedForRequest(request: NSURLRequest, callback: (items: [RSSItem]?, error: NSError?) -> Void)
    {
        let rssParser: RSSParser = RSSParser()
        
        rssParser.parseFeedForRequest(request, callback: callback)
    }
    
    var callbackClosure: ((items: [RSSItem]?, error: NSError?) -> Void)?
    var currentElement: String?
    var currentItem: RSSItem?
    var items: NSMutableArray! = NSMutableArray()
    
    // node names
    let node_item: String = "item"
    
    let node_title: String = "title"
    let node_link: String = "link"
    let node_guid: String = "guid"
    let node_publicationDate: String = "pubDate"
    let node_description: String = "description"
    let node_content: String = "content:encoded"
    
    func parseFeedForRequest(request: NSURLRequest, callback: (items: [RSSItem]?, error: NSError?) -> Void)
    {
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in

            if ((error) != nil)
            {
                callback(items: nil, error: error)
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
        self.callbackClosure!(items: items as AnyObject as? [RSSItem] ,error: nil)
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
        
        NSLog(elementName)
        
        if elementName == node_item
        {
            self.currentItem = RSSItem()
        }
        
        if ((self.currentItem) != nil)
        {
            currentElement = ""
        }
        
    }
   
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        NSLog(elementName)
        
        if elementName == node_item
        {
            items.addObject(self.currentItem!)
        }
        
        if ((self.currentItem) != nil)
        {
            if elementName == node_title
            {
                self.currentItem!.title = currentElement
            }
            
            if elementName == node_link
            {
                self.currentItem!.setLink(currentElement!)
            }
            
            if elementName == node_guid
            {
                self.currentItem!.guid = currentElement
            }
            
            if elementName == node_publicationDate
            {
                self.currentItem!.setPubDate(currentElement!)
            }
            
            if elementName == node_description
            {
                self.currentItem!.itemDescription = currentElement
            }
            
            if elementName == node_content
            {
                self.currentItem!.content = currentElement
            }
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if ((self.currentElement) != nil)
        {
            self.currentElement! += string
        }
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
            self.callbackClosure!(items: nil ,error: parseError)
    }

}