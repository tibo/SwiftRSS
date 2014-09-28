//
//  RSSParser.swift
//  SwiftRSS_Example
//
//  Created by Thibaut LE LEVIER on 05/09/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit

class RSSParser: NSObject, NSXMLParserDelegate {
    
    class func parseFeedForRequest(request: NSURLRequest, callback: (items: [NSString]?, error: NSError?) -> Void)
    {
        let rssParser: RSSParser = RSSParser()
        
        rssParser.parseFeedForRequest(request, callback: callback)
    }
    
    var callbackClosure: ((items: [NSString]?, error: NSError?) -> Void)?
    
    func parseFeedForRequest(request: NSURLRequest, callback: (items: [NSString]?, error: NSError?) -> Void)
    {
        
        callbackClosure = callback
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in

            var parser : NSXMLParser = NSXMLParser(data: data)
            parser.delegate = self
            parser.shouldResolveExternalEntities = false
            parser.parse()
        }
    }
    
// MARK: NSXMLParserDelegate
    func parserDidStartDocument(parser: NSXMLParser)
    {
        NSLog("start parsing")
    }
    
    func parserDidEndDocument(parser: NSXMLParser)
    {
        NSLog("end parsing")
        self.callbackClosure!(items: nil,error: nil)
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [NSObject : AnyObject]) {
            NSLog(elementName)
    }
   
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        NSLog(elementName)
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        NSLog(string)
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        NSLog("Error")
    }

}