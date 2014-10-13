//
//  RSSItem_Tests.swift
//  SwiftRSS_Example
//
//  Created by Thibaut LE LEVIER on 13/10/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit
import XCTest

class RSSItem_Tests: XCTestCase {
    
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
        var item: RSSItem = RSSItem()
        
        item.title = "Hello"
        item.setLink("http://www.apple.com")
        item.guid = "1234"
        item.pubDate = NSDate()
        item.itemDescription = "Big Description"
        item.content = "Here is the content"
        
        let archive = documentsPath.stringByAppendingString("test.archive")
        
        NSKeyedArchiver.archiveRootObject(item, toFile: archive)
        
        var item2 = NSKeyedUnarchiver.unarchiveObjectWithFile(archive) as RSSItem
        
        XCTAssert(item.title == item2.title, "")
        XCTAssert(item.link == item2.link, "")
        XCTAssert(item.guid == item2.guid, "")
        XCTAssert(item.pubDate == item2.pubDate, "")
        XCTAssert(item.itemDescription == item2.itemDescription, "")
        XCTAssert(item.content == item2.content, "")
    }

}
