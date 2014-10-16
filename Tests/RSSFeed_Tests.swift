//
//  RSSFeed_Tests.swift
//  SwiftRSS_Example
//
//  Created by Thibaut LE LEVIER on 16/10/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit
import XCTest

class RSSFeed_Tests: XCTestCase {
    
    let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func test_setLink_withAValidURLString_shouldCreateAValidURL()
    {
        var item: RSSItem = RSSItem()
        item.setLink("http://www.apple.com")
        
        if let link = item.link?
        {
            XCTAssert(true, "link is valid")
        }
        else
        {
            XCTFail("link should be valid")
        }
        
    }
    
    func test_archivingAndUnarchiving_withValidObject_shouldReturnValidObjectWithSameValues()
    {
        var feed: RSSFeed = RSSFeed()
        
        feed.title = "Feed title"
        feed.setLink("http://www.swift.io")
        feed.feedDescription = "Description of the feed"
        feed.language = "fr"
        feed.lastBuildDate = NSDate()
        feed.generator = "My Generator"
        feed.copyright = "Copyright Acme corp"
        
        var item: RSSItem = RSSItem()
        
        item.title = "Hello"
        item.setLink("http://www.apple.com")
        item.guid = "1234"
        item.pubDate = NSDate()
        item.itemDescription = "Big Description"
        item.content = "Here is the content"
        
        feed.items.append(item)
        
        var item2: RSSItem = RSSItem()
        
        item2.title = "Hello2"
        item2.setLink("http://www.google.com")
        item2.guid = "5678"
        item2.pubDate = NSDate()
        item2.itemDescription = "Big Description Again"
        item2.content = "Here is the content for the second item"
        
        feed.items.append(item2)
        
        let archive = documentsPath.stringByAppendingString("test.archive")
        
        NSKeyedArchiver.archiveRootObject(feed, toFile: archive)
        
        var feed2 = NSKeyedUnarchiver.unarchiveObjectWithFile(archive) as RSSFeed

        XCTAssert(feed.title == feed2.title, "")
        XCTAssert(feed.link == feed2.link, "")
        XCTAssert(feed.feedDescription == feed2.feedDescription, "")
        XCTAssert(feed.language == feed2.language, "")
        XCTAssert(feed.lastBuildDate == feed2.lastBuildDate, "")
        XCTAssert(feed.generator == feed2.generator, "")
        XCTAssert(feed.copyright == feed2.copyright, "")
        XCTAssert(feed.items.count == feed2.items.count, "")
        
        var itemcopy = feed2.items[0]
        
        XCTAssert(item.title == itemcopy.title, "")
        XCTAssert(item.link == itemcopy.link, "")
        XCTAssert(item.guid == itemcopy.guid, "")
        XCTAssert(item.pubDate == itemcopy.pubDate, "")
        XCTAssert(item.itemDescription == itemcopy.itemDescription, "")
        XCTAssert(item.content == itemcopy.content, "")
        
        var item2copy = feed2.items[1]
        
        XCTAssert(item2.title == item2copy.title, "")
        XCTAssert(item2.link == item2copy.link, "")
        XCTAssert(item2.guid == item2copy.guid, "")
        XCTAssert(item2.pubDate == item2copy.pubDate, "")
        XCTAssert(item2.itemDescription == item2copy.itemDescription, "")
        XCTAssert(item2.content == item2copy.content, "")
    }
}
