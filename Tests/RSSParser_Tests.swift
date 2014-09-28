//
//  Tests.swift
//  Tests
//
//  Created by Thibaut LE LEVIER on 05/09/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit
import XCTest

class RSSParser_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParseFeed() {
        
        let request: NSURLRequest = NSURLRequest(URL: NSURL(string: "http://developer.apple.com/swift/blog/news.rss"))
        let expectation = self.expectationWithDescription("GET \(request.URL)")
        
        RSSParser.parseFeedForRequest(request, callback: { (items, error) -> Void in
            
            expectation.fulfill()
            
            XCTAssert(true, "")
            
        })
        
        waitForExpectationsWithTimeout(100, handler: { error in
            
        })
        
        XCTAssert(true, "Pass")
    }
    
}
