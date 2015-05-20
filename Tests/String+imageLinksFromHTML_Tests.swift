//
//  String+ImageLinksFromHTML_Tests.swift
//  SwiftRSS_Example
//
//  Created by Thibaut LE LEVIER on 22/10/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit
import XCTest
import SwiftRSS

class String_ImageLinksFromHTML_Tests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // TODO: Issue with extensions in frameworks?
    // http://stackoverflow.com/questions/24175596/swift-framework-does-not-include-symbols-from-extensions-to-generic-structs
    /*func test_imageLinksFromHTMLString_withValidHTML_shouldReturnValidArrayOfURLs()
    {
        let mock: String = "Hello from <img src=\"http://apple.com/iphone.png\" /> or from <img src=\"http://apple.com/ipad.jpg\" /> or from <img src=\"https://google.com/android.gif\" /> or maybe <img src=\"http://microsoft.com/lumia.jpeg\" />"
        
        let links = mock.imageLinksFromHTMLString
        
        XCTAssertTrue(links.count == 4, "")
        XCTAssertTrue(links[0].absoluteString == "http://apple.com/iphone.png", "")
        XCTAssertTrue(links[1].absoluteString == "http://apple.com/ipad.jpg", "")
        XCTAssertTrue(links[2].absoluteString == "https://google.com/android.gif", "")
        XCTAssertTrue(links[3].absoluteString == "http://microsoft.com/lumia.jpeg", "")
    }

    func test_imagesLinksFromHTMLString_withRealMock_shouldReturnValidArrayOfURLs()
    {
        let mock: String = "<img src=\"http://33.media.tumblr.com/fc576f290358def5f021b7a99032aa0c/tumblr_nc05ipn7h61qjk2rvo1_500.jpg\"/><br/><br/><h2><a href=\"http://blog.segiddins.me/\">Sam Giddins: My Summer at Tumblr</a></h2><div><p>This summer, I had the immense pleasure of working on the Tumblr iOS app. From day one, I got to work with an incredible team on an incredible app writing production code. Over the course of nearly 100 pull requests, I managed to get my hands on almost every piece of the app, from design changes to code refactors to some sweet new features.<br/><br/>The best part about the summer was working alongside multiple teams at Tumblr (iOS, Creative, API) making real, significant changes to one of the most polished apps on the App Store. When the summer started, I’d never written a custom animation, but after a few weeks I was helping to debug some of the fun things we do with CoreAnimation. Monday of my second week I found a bug in the API and got to spend a day looking through PHP code to help track that down. One Friday, I started work on some new things that will come out soon—at 5 pm, on a whim. By Monday, I was demoing the changes to Peter Vidani. That sort of rapid feedback is incredible, and really made my experience at Tumblr a joy—I got to make a real difference on the app.<br/><br/>In addition to the code I wrote (which was a lot!), I got to work with the team on all of the other facets of the app development lifecycle, from the existential frustration of dealing with translations to setting up a CI build server. I review several hundred pull requests, and spent hours discussing code with brilliant collegues who were never hesitant to debate the intricacies of what we were working on.<br/><br/>Throughout the summer, I was constantly in awe of the amazing work done at Tumblr every day. I’m proud to say that I got to contribute to the next few updates, and will forever cherish the experiences I had during my time at Tumblr HQ.<br/><br/></p></div>"
        
        let links = mock.imageLinksFromHTMLString
        
        XCTAssert(links.count == 1, "")
        XCTAssert(links[0].absoluteString == "http://33.media.tumblr.com/fc576f290358def5f021b7a99032aa0c/tumblr_nc05ipn7h61qjk2rvo1_500.jpg", "")
        
    }*/
}
