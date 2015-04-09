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
    
    let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String

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
        
        if let link = item.link
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
        item.setCommentsLink("http://www.test.com")
        item.setCommentRSSLink("http://www.whatever.com/")
        item.commentsCount = 666
        item.author = "John Doe"
        item.categories = ["One","Two","Tree"]
        
        let archive = documentsPath.stringByAppendingString("test.archive")
        
        NSKeyedArchiver.archiveRootObject(item, toFile: archive)
        
        var item2 = NSKeyedUnarchiver.unarchiveObjectWithFile(archive) as! RSSItem
        
        XCTAssert(item.title == item2.title, "")
        XCTAssert(item.link == item2.link, "")
        XCTAssert(item.guid == item2.guid, "")
        XCTAssert(item.pubDate == item2.pubDate, "")
        XCTAssert(item.itemDescription == item2.itemDescription, "")
        XCTAssert(item.content == item2.content, "")
        XCTAssert(item.commentsLink!.absoluteString == item2.commentsLink!.absoluteString, "")
        XCTAssert(item.commentRSSLink!.absoluteString == item2.commentRSSLink!.absoluteString, "")
        XCTAssert(item.commentsCount == item2.commentsCount, "")
        XCTAssert(item.author == item2.author, "")
        XCTAssert(item.categories[0] == item2.categories[0], "")
        XCTAssert(item.categories[1] == item2.categories[1], "")
        XCTAssert(item.categories[2] == item2.categories[2], "")
    }

}
