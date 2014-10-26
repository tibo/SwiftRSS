//
//  String+ImageLinksFromHTML_Tests.swift
//  SwiftRSS_Example
//
//  Created by Thibaut LE LEVIER on 22/10/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit
import XCTest

class String_ImageLinksFromHTML_Tests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_imageLinksFromHTMLString_withValidHTML_shouldReturnValidArrayOfURLs()
    {
        let mock: String = "Hello from <img src=\"http://apple.com/iphone.png\" /> or from <img src=\"http://apple.com/ipad.jpg\" /> or from <img src=\"https://google.com/android.gif\" /> or maybe <img src=\"http://microsoft.com/lumia.jpeg\" />"
        
        let links = mock.imageLinksFromHTMLString
        
        XCTAssertTrue(links.count == 4, "")
        XCTAssertTrue(links[0].absoluteString == "http://apple.com/iphone.png", "")
        XCTAssertTrue(links[1].absoluteString == "http://apple.com/ipad.jpg", "")
        XCTAssertTrue(links[2].absoluteString == "https://google.com/android.gif", "")
        XCTAssertTrue(links[3].absoluteString == "http://microsoft.com/lumia.jpeg", "")
    }

}
