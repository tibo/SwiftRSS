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
    
    let mockFileURL = NSBundle(forClass: RSSParser_Tests.classForKeyedArchiver()).pathForResource("SwiftBlog", ofType: "rss")
    let invalidMockFileURL = NSBundle(forClass: RSSParser_Tests.classForKeyedArchiver()).pathForResource("Invalid", ofType: "rss")
    let wordpressMockFileURL = NSBundle(forClass: RSSParser_Tests.classForKeyedArchiver()).pathForResource("Wordpress", ofType: "rss")
    let tumblrMockFileURL = NSBundle(forClass: RSSParser_Tests.classForKeyedArchiver()).pathForResource("Tumblr", ofType: "rss")
    let emptyMockFileURL = NSBundle(forClass: RSSParser_Tests.classForKeyedArchiver()).pathForResource("Empty", ofType: "rss")
    
    let PDT_timeZone = NSTimeZone(name: "PST")
    let GMT_timeZone = NSTimeZone(name: "GMT")
    let DST_timeZone = NSTimeZone(forSecondsFromGMT: 60 * 60 * -4)
    let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
    let calendar_flags = NSCalendarUnit(UInt.max)
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_parser_withValidMock_shouldReturnTheRightValues() {
        
        let request: NSURLRequest = NSURLRequest(URL: NSURL(fileURLWithPath: mockFileURL!))
        let expectation = self.expectationWithDescription("GET \(request.URL)")
        
        RSSParser.parseFeedForRequest(request, callback: { (feedMeta, items, error) -> Void in
            
            expectation.fulfill()
            
            self.calendar.timeZone = self.PDT_timeZone
            
            XCTAssert((items!.count == 15), "number of items should be equal to 16")
            XCTAssertNil(error, "error should be nil")
            
            if let meta = feedMeta?
            {
                XCTAssert(meta.title == "Swift Blog - Apple Developer", "")
                if let link = meta.link?
                {
                    XCTAssert(link.absoluteString == "http://developer.apple.com/swift/blog/", "")
                }
                XCTAssert(meta.feedDescription == "Get the latest news and helpful tips on the Swift programming language from the engineers who created it.", "")
                
                XCTAssert(meta.language == "en-US", "")
                
                if let date = meta.lastBuildDate?
                {
                    var dateComponent = self.calendar.components(self.calendar_flags, fromDate: date)
                    
                    XCTAssert(dateComponent.weekday == 5, "")
                    XCTAssert(dateComponent.day == 25, "")
                    XCTAssert(dateComponent.month == 9, "")
                    XCTAssert(dateComponent.year == 2014, "")
                    XCTAssert(dateComponent.hour == 10, "")
                    XCTAssert(dateComponent.minute == 0, "")
                    XCTAssert(dateComponent.second == 0, "")
                    XCTAssert(dateComponent.timeZone!.isEqualToTimeZone(self.PDT_timeZone), "")
                }
                else
                {
                    XCTFail("lastBuildDate shouldn't be nil")
                }
                
                XCTAssert(meta.generator == "Custom", "")
                XCTAssert(meta.copyright == "Copyright 2014, Apple Inc.", "")
            }
            else
            {
                XCTFail("feed meta shouldn't be nil")
            }
            
            var myItem: RSSItem = items![0]
            
            XCTAssert(myItem.title == "Building  assert()  in Swift, Part 2:  __FILE__  and  __LINE__ ", "")
            
            if let link = myItem.link?
            {
                XCTAssert(link.absoluteString == "http://developer.apple.com/swift/blog/?id=15", "")
            }
            else
            {
                XCTFail("link shouldn't be nil")
            }
            
            XCTAssert(myItem.guid == "http://developer.apple.com/swift/blog/?id=15", "")
            
            if let date = myItem.pubDate?
            {
                var dateComponent = self.calendar.components(self.calendar_flags, fromDate: date)
                
                XCTAssert(dateComponent.weekday == 5, "")
                XCTAssert(dateComponent.day == 25, "")
                XCTAssert(dateComponent.month == 9, "")
                XCTAssert(dateComponent.year == 2014, "")
                XCTAssert(dateComponent.hour == 10, "")
                XCTAssert(dateComponent.minute == 0, "")
                XCTAssert(dateComponent.second == 0, "")
                XCTAssert(dateComponent.timeZone!.isEqualToTimeZone(self.PDT_timeZone), "")
            }
            else
            {
                XCTFail("pubDate shouldn't be nil")
            }
            
            XCTAssert(myItem.itemDescription == " Two occasionally useful features of C are the  __FILE__  and  __LINE__  magic macros. These are built into the preprocessor, and expanded out before the C parser is run. Despite not having a preprocessor, Swift provides very similar functionality with similar names, but Swift works quite differently under the covers.  Built-In Identifiers  As described in  the Swift programming guide , Swift has a number of built-in identifiers, including   __FILE__ ,  __LINE__ ,  __COLUMN__ , and  __FUNCTION__ . These expressions can be used anywhere and are expanded by the parser to string or integer literals that correspond to the current location in the source code. This is incredibly useful for manual logging, e.g. to print out the current position before quitting.  However, this doesn’t help us in our quest to implement  assert() .  If we defined assert like this:  [view code in blog]  The above code would print out of the file/line location that implements  assert()  itself, not the location from the caller. That isn’t helpful.  Getting the location of a caller  Swift borrows a clever feature from the D language: these identifiers expand to the location of the caller  when evaluated in a default argument list .  To enable this behavior, the  assert()  function is defined something like this:  [view code in blog]  The second parameter to the Swift  assert()  function is an optional string that you can specify, and the third and forth arguments are defaulted to be the position in the caller’s context.  This allows  assert()  to pick up the source location of the caller by default, and if you want to define your own abstractions on top of assert, you can pass down locations from its caller.  As a trivial example, you could define a function that logs and asserts like this:  [view code in blog]  This properly propagates the file/line location of the  logAndAssert()  caller down to the implementation of  assert() . Note that  StaticString , as shown in the code above, is a simple  String-like  type used to store a string literal, such as one produced by  __FILE__ , with no  memory-management  overhead.  In addition to being useful for  assert() , this functionality is used in the Swift implementation of the higher-level XCTest framework, and may be useful for your own libraries as well. ", "")
            XCTAssert(myItem.content == "<p>Two occasionally useful features of C are the <span class=\"keyword\">__FILE__</span> and <span class=\"keyword\">__LINE__</span> magic macros. These are built into the preprocessor, and expanded out before the C parser is run. Despite not having a preprocessor, Swift provides very similar functionality with similar names, but Swift works quite differently under the covers.</p><h3>Built-In Identifiers</h3><p>As described in <a href=\"http://developer.apple.com/library/prerelease/ios/documentation/swift/conceptual/swift_programming_language/LexicalStructure.html\">the Swift programming guide</a>, Swift has a number of built-in identifiers, including  <span class=\"keyword\">__FILE__</span>, <span class=\"keyword\">__LINE__</span>, <span class=\"keyword\">__COLUMN__</span>, and <span class=\"keyword\">__FUNCTION__</span>. These expressions can be used anywhere and are expanded by the parser to string or integer literals that correspond to the current location in the source code. This is incredibly useful for manual logging, e.g. to print out the current position before quitting.</p><p>However, this doesn’t help us in our quest to implement <span class=\"keyword\">assert()</span>.  If we defined assert like this:</p><a href=\"http://developer.apple.com/swift/blog/?id=15\">[view code in blog]</a><p>The above code would print out of the file/line location that implements <span class=\"keyword\">assert()</span> itself, not the location from the caller. That isn’t helpful.</p><h3>Getting the location of a caller</h3><p>Swift borrows a clever feature from the D language: these identifiers expand to the location of the caller <em>when evaluated in a default argument list</em>.  To enable this behavior, the <span class=\"keyword\">assert()</span> function is defined something like this:</p><a href=\"http://developer.apple.com/swift/blog/?id=15\">[view code in blog]</a><p>The second parameter to the Swift <span class=\"keyword\">assert()</span> function is an optional string that you can specify, and the third and forth arguments are defaulted to be the position in the caller’s context.  This allows <span class=\"keyword\">assert()</span> to pick up the source location of the caller by default, and if you want to define your own abstractions on top of assert, you can pass down locations from its caller.  As a trivial example, you could define a function that logs and asserts like this:</p><a href=\"http://developer.apple.com/swift/blog/?id=15\">[view code in blog]</a><p>This properly propagates the file/line location of the <span class=\"keyword\">logAndAssert()</span> caller down to the implementation of <span class=\"keyword\">assert()</span>. Note that <span class=\"keyword\">StaticString</span>, as shown in the code above, is a simple <span class=\"nowrap\">String-like</span> type used to store a string literal, such as one produced by <span class=\"keyword\">__FILE__</span>, with no <span class=\"nowrap\">memory-management</span> overhead.</p><p>In addition to being useful for <span class=\"keyword\">assert()</span>, this functionality is used in the Swift implementation of the higher-level XCTest framework, and may be useful for your own libraries as well.</p>", "")
            
            myItem = items![1]
            
            XCTAssert(myItem.title == "Swift Has Reached 1.0", "")
            
            if let link = myItem.link?
            {
                XCTAssert(link.absoluteString == "http://developer.apple.com/swift/blog/?id=14", "")
            }
            else
            {
                XCTFail("link shouldn't be nil")
            }
            
            XCTAssert(myItem.guid == "http://developer.apple.com/swift/blog/?id=14", "")
            
            if let date = myItem.pubDate?
            {
                var dateComponent = self.calendar.components(self.calendar_flags, fromDate: date)
                
                XCTAssert(dateComponent.weekday == 3, "")
                XCTAssert(dateComponent.day == 9, "")
                XCTAssert(dateComponent.month == 9, "")
                XCTAssert(dateComponent.year == 2014, "")
                XCTAssert(dateComponent.hour == 11, "")
                XCTAssert(dateComponent.minute == 0, "")
                XCTAssert(dateComponent.second == 0, "")
                XCTAssert(dateComponent.timeZone!.isEqualToTimeZone(self.PDT_timeZone), "")
            }
            else
            {
                XCTFail("pubDate shouldn't be nil")
            }
            
            XCTAssert(myItem.itemDescription == " On June 2, 2014 at WWDC, the Swift team finally showed you what we had been working on for years. That was a  big day with lots of excitement, for us and for developers around the world. Today, we’ve reached the second giant milestone:  Swift version 1.0 is now GM.  You can now submit your apps that use Swift to the App Store. Whether your app uses Swift for a small feature or a complete application, now is the time to share your app with the world. It’s your turn to excite everyone with your new creations.  Swift for OS X  Today is the GM date for Swift on iOS. We have one more GM date to go for Mac. Swift for OS X currently requires the SDK for OS X Yosemite, and when Yosemite ships later this fall, Swift will also be GM on the Mac. In the meantime, you can keep developing your Mac apps with Swift by downloading the beta of  Xcode 6.1 .  The Road Ahead  You’ll notice we’re using the word “GM”, not “final”. That’s because Swift will continue to advance with new features, improved performance, and refined syntax. In fact, you can expect a few improvements to come in Xcode 6.1 in time for the Yosemite launch. Because your apps today embed a version of the Swift GM runtime, they will continue to run well into the future. ", "")
            XCTAssert(myItem.content == "<p>On June 2, 2014 at WWDC, the Swift team finally showed you what we had been working on for years. That was a  big day with lots of excitement, for us and for developers around the world. Today, we’ve reached the second giant milestone:</p><p>Swift version 1.0 is now GM.</p><p>You can now submit your apps that use Swift to the App Store. Whether your app uses Swift for a small feature or a complete application, now is the time to share your app with the world. It’s your turn to excite everyone with your new creations.</p><h3>Swift for OS X</h3><p>Today is the GM date for Swift on iOS. We have one more GM date to go for Mac. Swift for OS X currently requires the SDK for OS X Yosemite, and when Yosemite ships later this fall, Swift will also be GM on the Mac. In the meantime, you can keep developing your Mac apps with Swift by downloading the beta of <a href=\"http://developer.apple.com/xcode/downloads/\">Xcode 6.1</a>.</p><h3>The Road Ahead</h3><p>You’ll notice we’re using the word “GM”, not “final”. That’s because Swift will continue to advance with new features, improved performance, and refined syntax. In fact, you can expect a few improvements to come in Xcode 6.1 in time for the Yosemite launch. Because your apps today embed a version of the Swift GM runtime, they will continue to run well into the future.</p>", "")
            
            myItem = items![2]
            
            XCTAssert(myItem.title == "Patterns Playground", "")
            
            if let link = myItem.link?
            {
                XCTAssert(link.absoluteString == "http://developer.apple.com/swift/blog/?id=13", "")
            }
            else
            {
                XCTFail("link shouldn't be nil")
            }
            
            XCTAssert(myItem.guid == "http://developer.apple.com/swift/blog/?id=13", "")
            
            if let date = myItem.pubDate?
            {
                var dateComponent = self.calendar.components(self.calendar_flags, fromDate: date)
                
                XCTAssert(dateComponent.weekday == 4, "")
                XCTAssert(dateComponent.day == 3, "")
                XCTAssert(dateComponent.month == 9, "")
                XCTAssert(dateComponent.year == 2014, "")
                XCTAssert(dateComponent.hour == 9, "")
                XCTAssert(dateComponent.minute == 0, "")
                XCTAssert(dateComponent.second == 0, "")
                XCTAssert(dateComponent.timeZone!.isEqualToTimeZone(self.PDT_timeZone), "")
            }
            else
            {
                XCTFail("pubDate shouldn't be nil")
            }
            
            XCTAssert(myItem.itemDescription == " In Swift, a pattern is a way to describe and match a set of values based on certain rules, such as:    All tuples whose first value is 0  All numbers in the range 1...5  All class instances of a certain type   The learning playground linked below includes embedded documentation and experiments for you to perform. Download it for an interactive experience that will give you a jump start into using patterns in your own apps.  This playground requires the latest beta version of Xcode 6 on OS X Mavericks or OS X Yosemite beta. ", "")
            XCTAssert(myItem.content == "<p>In Swift, a pattern is a way to describe and match a set of values based on certain rules, such as: </p><ul class=\"tight\"><li>All tuples whose first value is 0</li><li>All numbers in the range 1...5</li><li>All class instances of a certain type</li></ul><p>The learning playground linked below includes embedded documentation and experiments for you to perform. Download it for an interactive experience that will give you a jump start into using patterns in your own apps.</p><p>This playground requires the latest beta version of Xcode 6 on OS X Mavericks or OS X Yosemite beta.</p>", "")
            
            myItem = items![3]
            
            XCTAssert(myItem.title == "Optionals Case Study:  valuesForKeys ", "")
            
            if let link = myItem.link?
            {
                XCTAssert(link.absoluteString == "http://developer.apple.com/swift/blog/?id=12", "")
            }
            else
            {
                XCTFail("link shouldn't be nil")
            }
            
            XCTAssert(myItem.guid == "http://developer.apple.com/swift/blog/?id=12", "")
            
            if let date = myItem.pubDate?
            {
                var dateComponent = self.calendar.components(self.calendar_flags, fromDate: date)
                
                XCTAssert(dateComponent.weekday == 3, "")
                XCTAssert(dateComponent.day == 26, "")
                XCTAssert(dateComponent.month == 8, "")
                XCTAssert(dateComponent.year == 2014, "")
                XCTAssert(dateComponent.hour == 14, "")
                XCTAssert(dateComponent.minute == 0, "")
                XCTAssert(dateComponent.second == 0, "")
                XCTAssert(dateComponent.timeZone!.isEqualToTimeZone(self.PDT_timeZone), "")
            }
            else
            {
                XCTFail("pubDate shouldn't be nil")
            }
            
            XCTAssert(myItem.itemDescription == " This post explores how optionals help preserve strong type safety within Swift. We’re going to create a Swift version of an Objective-C API. Swift doesn’t really need this API, but it makes for a fun example.  In Objective-C,  NSDictionary  has a method  -objectsForKeys:notFoundMarker:  that takes an  NSArray  of keys, and returns an  NSArray  of corresponding values. From the documentation: “the  N -th object in the returned array corresponds to the  N -th key in [the input parameter] keys.” What if the third key isn’t actually in the dictionary? That’s where the  notFoundMarker  parameter comes in. The third element in the array will be this marker object rather than a value from the dictionary. The Foundation framework even provides a class for this case if you don’t have another to use:  NSNull .  In Swift, the  Dictionary  type doesn’t have an  objectsForKeys  equivalent. For this exercise, we’re going to add one — as  valuesForKeys  in keeping with the common use of ‘value’ in Swift — using an extension:  [view code in blog]  This is where our new implementation in Swift will differ from Objective-C. In Swift, the stronger typing restricts the resulting array to contain only a single type of element — we can’t put  NSNull  in an array of strings. However, Swift gives an even better option: we can return an  array of optionals . All our values get wrapped in optionals, and instead of  NSNull , we just use  nil .  [view code in blog]  NOTE: Some of you may have guessed why a Swift  Dictionary  doesn’t need this API, and already imagined something like this:  [view code in blog]  This has the exact same effect as the imperative version above, but all of the boilerplate has been wrapped up in the call to  map . This is great example why Swift types often have a small API surface area, because it’s so easy to just call  map  directly.  Now we can try out some examples:  [view code in blog]  Nested Optionals  Now, what if we asked for the  last  element of each result?  [view code in blog]  That’s strange — we have two levels of  Optional  in the first case, and  Optional(nil)  in the second case. What’s going on?  Remember the declaration of the  last  property:  [view code in blog]  This says that the  last  property’s type is an  Optional  version of the array’s element type. In  this  case, the element type is also optional ( String? ). So we end up with  String?? , a doubly-nested optional type.  So what does  Optional(nil)  mean?  Recall that in Objective-C we were going to use  NSNull  as a placeholder. The Objective-C version of these three calls looks like this:  [view code in blog]  In both the Swift and Objective-C cases, a return value of  nil  means “the array is empty, therefore there’s no last element.” The return value of  Optional(nil)  (or in Objective-C  NSNull ) means “the last element of this array exists, but it represents an absence.” Objective-C has to rely on a placeholder object to do this, but Swift can represent it in the type system.  Providing a Default  To wrap up, what if you  did  want to provide a default value for anything that wasn’t in the dictionary? Well, that’s easy enough.  [view code in blog]  While Objective-C has to rely on a placeholder object to do this, Swift can represent it in the type system, and provides rich syntactic support for handling optional results. ", "")
            XCTAssert(myItem.content == "<p>This post explores how optionals help preserve strong type safety within Swift. We’re going to create a Swift version of an Objective-C API. Swift doesn’t really need this API, but it makes for a fun example.</p><p>In Objective-C, <span class=\"keyword\">NSDictionary</span> has a method <span class=\"keyword\">-objectsForKeys:notFoundMarker:</span> that takes an <span class=\"keyword\">NSArray</span> of keys, and returns an <span class=\"keyword\">NSArray</span> of corresponding values. From the documentation: “the <em>N</em>-th object in the returned array corresponds to the <em>N</em>-th key in [the input parameter] keys.” What if the third key isn’t actually in the dictionary? That’s where the <span class=\"keyword\">notFoundMarker</span> parameter comes in. The third element in the array will be this marker object rather than a value from the dictionary. The Foundation framework even provides a class for this case if you don’t have another to use: <span class=\"keyword\">NSNull</span>.</p><p>In Swift, the <span class=\"keyword\">Dictionary</span> type doesn’t have an <span class=\"keyword\">objectsForKeys</span> equivalent. For this exercise, we’re going to add one — as <span class=\"keyword\">valuesForKeys</span> in keeping with the common use of ‘value’ in Swift — using an extension:</p><a href=\"http://developer.apple.com/swift/blog/?id=12\">[view code in blog]</a><p>This is where our new implementation in Swift will differ from Objective-C. In Swift, the stronger typing restricts the resulting array to contain only a single type of element — we can’t put <span class=\"keyword\">NSNull</span> in an array of strings. However, Swift gives an even better option: we can return an <emn>array of optionals</em>. All our values get wrapped in optionals, and instead of <span class=\"keyword\">NSNull</span>, we just use <span class=\"keyword\">nil</span>.</p><a href=\"http://developer.apple.com/swift/blog/?id=12\">[view code in blog]</a><p>NOTE: Some of you may have guessed why a Swift <span class=\"keyword\">Dictionary</span> doesn’t need this API, and already imagined something like this:</p><a href=\"http://developer.apple.com/swift/blog/?id=12\">[view code in blog]</a><p>This has the exact same effect as the imperative version above, but all of the boilerplate has been wrapped up in the call to <span class=\"keyword\">map</span>. This is great example why Swift types often have a small API surface area, because it’s so easy to just call <span class=\"keyword\">map</span> directly.</p><p>Now we can try out some examples:</p><a href=\"http://developer.apple.com/swift/blog/?id=12\">[view code in blog]</a><h3>Nested Optionals</h3><p>Now, what if we asked for the <span class=\"keyword\">last</span> element of each result?</p><a href=\"http://developer.apple.com/swift/blog/?id=12\">[view code in blog]</a><p>That’s strange — we have two levels of <span class=\"keyword\">Optional</span> in the first case, and <span class=\"keyword\">Optional(nil)</span> in the second case. What’s going on?</p><p>Remember the declaration of the <span class=\"keyword\">last</span> property:</p><a href=\"http://developer.apple.com/swift/blog/?id=12\">[view code in blog]</a><p>This says that the <span class=\"keyword\">last</span> property’s type is an <span class=\"keyword\">Optional</span> version of the array’s element type. In <em>this</em> case, the element type is also optional (<span class=\"keyword\">String?</span>). So we end up with <span class=\"keyword\">String??</span>, a doubly-nested optional type.</p><p>So what does <span class=\"keyword\">Optional(nil)</span> mean?</p><p>Recall that in Objective-C we were going to use <span class=\"keyword\">NSNull</span> as a placeholder. The Objective-C version of these three calls looks like this:</p><a href=\"http://developer.apple.com/swift/blog/?id=12\">[view code in blog]</a><p>In both the Swift and Objective-C cases, a return value of <span class=\"keyword\">nil</span> means “the array is empty, therefore there’s no last element.” The return value of <span class=\"keyword\">Optional(nil)</span> (or in Objective-C <span class=\"keyword\">NSNull</span>) means “the last element of this array exists, but it represents an absence.” Objective-C has to rely on a placeholder object to do this, but Swift can represent it in the type system.</p><h3>Providing a Default</h3><p>To wrap up, what if you <em>did</em> want to provide a default value for anything that wasn’t in the dictionary? Well, that’s easy enough.</p><a href=\"http://developer.apple.com/swift/blog/?id=12\">[view code in blog]</a><p>While Objective-C has to rely on a placeholder object to do this, Swift can represent it in the type system, and provides rich syntactic support for handling optional results.</p>", "")
            
            myItem = items![4]
            
            XCTAssert(myItem.title == "Access Control and  protected ", "")
            
            if let link = myItem.link?
            {
                XCTAssert(link.absoluteString == "http://developer.apple.com/swift/blog/?id=11", "")
            }
            else
            {
                XCTFail("link shouldn't be nil")
            }
            
            XCTAssert(myItem.guid == "http://developer.apple.com/swift/blog/?id=11", "")
            
            if let date = myItem.pubDate?
            {
                var dateComponent = self.calendar.components(self.calendar_flags, fromDate: date)
                
                XCTAssert(dateComponent.weekday == 3, "")
                XCTAssert(dateComponent.day == 19, "")
                XCTAssert(dateComponent.month == 8, "")
                XCTAssert(dateComponent.year == 2014, "")
                XCTAssert(dateComponent.hour == 10, "")
                XCTAssert(dateComponent.minute == 0, "")
                XCTAssert(dateComponent.second == 0, "")
                XCTAssert(dateComponent.timeZone!.isEqualToTimeZone(self.PDT_timeZone), "")
            }
            else
            {
                XCTFail("pubDate shouldn't be nil")
            }
            
            XCTAssert(myItem.itemDescription == " The response to support for access control in Swift has been extremely positive. However, some developers have been asking, “Why doesn’t Swift have something like  protected ?” Many other programming languages have an access control option that restricts certain methods from being accessed from anywhere except subclasses.  When designing access control levels in Swift, we considered two main use cases:   keep  private  details of a class hidden from the rest of the app  keep  internal  details of a framework hidden from the client app   These correspond to  private  and  internal  levels of access, respectively.  In contrast,  protected  conflates access with inheritance, adding an entirely new control axis to reason about. It doesn’t actually offer any real protection, since a subclass can always expose “protected” API through a new public method or property. It doesn’t offer  additional optimization opportunities either, since new overrides can come from anywhere. And it’s unnecessarily restrictive — it allows subclasses, but not any of the subclass’s helpers, to access something.  As some developers have pointed out, Apple frameworks do occasionally separate parts of API intended for use by subclasses. Wouldn’t  protected  be helpful here? Upon inspection, these methods generally fall into one of two groups. First, methods that aren’t really useful outside the subclass, so protection isn’t critical (and recall the helper case above). Second, methods that are designed to be overridden but not called. An example is  drawRect(_:) , which is certainly used within the UIKit codebase but is not to be called outside UIKit.  It’s also not clear how  protected  should interact with extensions. Does an extension to a class have access to that class’s protected members? Does an extension to a subclass have access to the superclass’s protected members? Does it make a difference if the extension is declared in the same module as the class?  There was one other influence that led us to the current design: existing practices of Objective-C developers both inside and outside of Apple. Objective-C methods and properties are generally declared in a public header (.h) file, but can also be added in class extensions within the implementation (.m) file. When parts of a public class are intended for use elsewhere within the framework but not outside, developers create a second header file with the class’s “internal” bits. These three levels of access correspond to  public ,  private , and  internal  in Swift.  Swift provides access control along a single, easy-to-understand axis, unrelated to inheritance. We believe this model is simpler, and provides access control the way it is most often needed: to isolate implementation details to within a class or within a framework. It may be different from what you’ve used before, but we encourage you to try it out. ", "")
            XCTAssert(myItem.content == "<p>The response to support for access control in Swift has been extremely positive. However, some developers have been asking, “Why doesn’t Swift have something like <span class=\"keyword\">protected</span>?” Many other programming languages have an access control option that restricts certain methods from being accessed from anywhere except subclasses.</p><p>When designing access control levels in Swift, we considered two main use cases:</p><ul class=\"tight\"><li>keep <span class=\"keyword\">private</span> details of a class hidden from the rest of the app</li><li>keep <span class=\"keyword\">internal</span> details of a framework hidden from the client app</li></ul><p>These correspond to <span class=\"keyword\">private</span> and <span class=\"keyword\">internal</span> levels of access, respectively.</p><p>In contrast, <span class=\"keyword\">protected</span> conflates access with inheritance, adding an entirely new control axis to reason about. It doesn’t actually offer any real protection, since a subclass can always expose “protected” API through a new public method or property. It doesn’t offer  additional optimization opportunities either, since new overrides can come from anywhere. And it’s unnecessarily restrictive — it allows subclasses, but not any of the subclass’s helpers, to access something.</p><p>As some developers have pointed out, Apple frameworks do occasionally separate parts of API intended for use by subclasses. Wouldn’t <span class=\"keyword\">protected</span> be helpful here? Upon inspection, these methods generally fall into one of two groups. First, methods that aren’t really useful outside the subclass, so protection isn’t critical (and recall the helper case above). Second, methods that are designed to be overridden but not called. An example is <span class=\"keyword\">drawRect(_:)</span>, which is certainly used within the UIKit codebase but is not to be called outside UIKit.</p><p>It’s also not clear how <span class=\"keyword\">protected</span> should interact with extensions. Does an extension to a class have access to that class’s protected members? Does an extension to a subclass have access to the superclass’s protected members? Does it make a difference if the extension is declared in the same module as the class?</p><p>There was one other influence that led us to the current design: existing practices of Objective-C developers both inside and outside of Apple. Objective-C methods and properties are generally declared in a public header (.h) file, but can also be added in class extensions within the implementation (.m) file. When parts of a public class are intended for use elsewhere within the framework but not outside, developers create a second header file with the class’s “internal” bits. These three levels of access correspond to <span class=\"keyword\">public</span>, <span class=\"keyword\">private</span>, and <span class=\"keyword\">internal</span> in Swift.</p><p>Swift provides access control along a single, easy-to-understand axis, unrelated to inheritance. We believe this model is simpler, and provides access control the way it is most often needed: to isolate implementation details to within a class or within a framework. It may be different from what you’ve used before, but we encourage you to try it out.</p>", "")
            
            myItem = items![5]
            
            XCTAssert(myItem.title == "Value and Reference Types", "")
            
            if let link = myItem.link?
            {
                XCTAssert(link.absoluteString == "http://developer.apple.com/swift/blog/?id=10", "")
            }
            else
            {
                XCTFail("link shouldn't be nil")
            }
            
            XCTAssert(myItem.guid == "http://developer.apple.com/swift/blog/?id=10", "")
            
            if let date = myItem.pubDate?
            {
                var dateComponent = self.calendar.components(self.calendar_flags, fromDate: date)
                
                XCTAssert(dateComponent.weekday == 6, "")
                XCTAssert(dateComponent.day == 15, "")
                XCTAssert(dateComponent.month == 8, "")
                XCTAssert(dateComponent.year == 2014, "")
                XCTAssert(dateComponent.hour == 13, "")
                XCTAssert(dateComponent.minute == 30, "")
                XCTAssert(dateComponent.second == 0, "")
                XCTAssert(dateComponent.timeZone!.isEqualToTimeZone(self.PDT_timeZone), "")
            }
            else
            {
                XCTFail("pubDate shouldn't be nil")
            }
            
            XCTAssert(myItem.itemDescription == " Types in Swift fall into one of two categories: first, “value types”, where each instance keeps a unique copy of its data, usually defined as a  struct ,  enum , or tuple. The second, “reference types”, where instances share a single copy of the data, and the type is usually defined as a  class . In this post we explore the merits of value and reference types, and how to choose between them.     What’s the Difference?    The most basic distinguishing feature of a  value type  is that copying — the effect of assignment, initialization, and argument passing — creates an  independent instance  with its own unique copy of its data:   [view code in blog]   Copying a reference, on the other hand, implicitly creates a shared instance. After a copy, two variables then refer to a single instance of the data, so modifying data in the second variable also affects the original, e.g.:   [view code in blog]   The Role of Mutation in Safety   One of the primary reasons to choose value types over reference types is the ability to more easily reason about your code. If you always get a unique, copied instance, you can trust that no other part of your app is changing the data under the covers. This is especially helpful in multi-threaded environments where a different thread could alter your data out from under you. This can create nasty bugs that are extremely hard to debug.   Because the difference is defined in terms of what happens when you change data, there’s one case where value and reference types overlap: when instances have no writable data. In the absence of mutation, values and references act exactly the same way.   You may be thinking that it could be valuable, then, to have a case where a  class  is completely immutable. This would make it easier to use Cocoa  NSObject  objects, while maintaining the benefits of value semantics. Today, you can write an immutable class in Swift by using only immutable stored properties and avoiding exposing any APIs that can modify state. In fact, many common Cocoa classes, such as  NSURL , are designed as immutable classes. However, Swift does not currently provide any language mechanism to enforce  class  immutability (e.g. on subclasses) the way it enforces immutability for  struct  and  enum .   How to Choose?   So if you want to build a new type, how do you decide which kind to make? When you’re working with Cocoa, many APIs expect subclasses of  NSObject , so you have to use a  class . For the other cases, here are some guidelines:   Use a value type when:     Comparing instance data with  ==  makes sense   You want copies to have independent state   The data will be used in code across multiple threads     Use a reference type (e.g. use a  class ) when:     Comparing instance identity with  ===  makes sense   You want to create shared, mutable state     In Swift,  Array ,  String , and  Dictionary  are all value types. They behave much like a simple  int  value in C, acting as a unique instance of that data. You don’t need to do anything special — such as making an explicit copy — to prevent other code from modifying that data behind your back. Importantly, you can safely pass copies of values across threads without synchronization. In the spirit of improving safety, this model will help you write more predictable code in Swift. ", "")
            XCTAssert(myItem.content == "<p>Types in Swift fall into one of two categories: first, “value types”, where each instance keeps a unique copy of its data, usually defined as a <span class=\"keyword\">struct</span>, <span class=\"keyword\">enum</span>, or tuple. The second, “reference types”, where instances share a single copy of the data, and the type is usually defined as a <span class=\"keyword\">class</span>. In this post we explore the merits of value and reference types, and how to choose between them. </p> <h3> What’s the Difference? </h3> <p>The most basic distinguishing feature of a <em>value type</em> is that copying — the effect of assignment, initialization, and argument passing — creates an <em>independent instance</em> with its own unique copy of its data:</p> <a href=\"http://developer.apple.com/swift/blog/?id=10\">[view code in blog]</a> <p>Copying a reference, on the other hand, implicitly creates a shared instance. After a copy, two variables then refer to a single instance of the data, so modifying data in the second variable also affects the original, e.g.:</p> <a href=\"http://developer.apple.com/swift/blog/?id=10\">[view code in blog]</a> <h3>The Role of Mutation in Safety</h3> <p>One of the primary reasons to choose value types over reference types is the ability to more easily reason about your code. If you always get a unique, copied instance, you can trust that no other part of your app is changing the data under the covers. This is especially helpful in multi-threaded environments where a different thread could alter your data out from under you. This can create nasty bugs that are extremely hard to debug.</p> <p>Because the difference is defined in terms of what happens when you change data, there’s one case where value and reference types overlap: when instances have no writable data. In the absence of mutation, values and references act exactly the same way.</p> <p>You may be thinking that it could be valuable, then, to have a case where a <span class=\"keyword\">class</span> is completely immutable. This would make it easier to use Cocoa <span class=\"keyword\">NSObject</span> objects, while maintaining the benefits of value semantics. Today, you can write an immutable class in Swift by using only immutable stored properties and avoiding exposing any APIs that can modify state. In fact, many common Cocoa classes, such as <span class=\"keyword\">NSURL</span>, are designed as immutable classes. However, Swift does not currently provide any language mechanism to enforce <span class=\"keyword\">class</span> immutability (e.g. on subclasses) the way it enforces immutability for <span class=\"keyword\">struct</span> and <span class=\"keyword\">enum</span>.</p> <h3>How to Choose?</h3> <p>So if you want to build a new type, how do you decide which kind to make? When you’re working with Cocoa, many APIs expect subclasses of <span class=\"keyword\">NSObject</span>, so you have to use a <span class=\"keyword\">class</span>. For the other cases, here are some guidelines:</p> <p>Use a value type when:</p> <ul class=\"tight\"> <li>Comparing instance data with <span class=\"keyword\">==</span> makes sense</li> <li>You want copies to have independent state</li> <li>The data will be used in code across multiple threads</li> </ul> <p>Use a reference type (e.g. use a <span class=\"keyword\">class</span>) when:</p> <ul class=\"tight\"> <li>Comparing instance identity with <span class=\"keyword\">===</span> makes sense</li> <li>You want to create shared, mutable state</li> </ul> <p>In Swift, <span class=\"keyword\">Array</span>, <span class=\"keyword\">String</span>, and <span class=\"keyword\">Dictionary</span> are all value types. They behave much like a simple <span class=\"keyword\">int</span> value in C, acting as a unique instance of that data. You don’t need to do anything special — such as making an explicit copy — to prevent other code from modifying that data behind your back. Importantly, you can safely pass copies of values across threads without synchronization. In the spirit of improving safety, this model will help you write more predictable code in Swift.</p>", "")
            
            myItem = items![6]
            
            XCTAssert(myItem.title == "Balloons", "")
            
            if let link = myItem.link?
            {
                XCTAssert(link.absoluteString == "http://developer.apple.com/swift/blog/?id=9", "")
            }
            else
            {
                XCTFail("link shouldn't be nil")
            }
            
            XCTAssert(myItem.guid == "http://developer.apple.com/swift/blog/?id=9", "")
            
            if let date = myItem.pubDate?
            {
                var dateComponent = self.calendar.components(self.calendar_flags, fromDate: date)
                
                XCTAssert(dateComponent.weekday == 6, "")
                XCTAssert(dateComponent.day == 8, "")
                XCTAssert(dateComponent.month == 8, "")
                XCTAssert(dateComponent.year == 2014, "")
                XCTAssert(dateComponent.hour == 11, "")
                XCTAssert(dateComponent.minute == 0, "")
                XCTAssert(dateComponent.second == 0, "")
                XCTAssert(dateComponent.timeZone!.isEqualToTimeZone(self.PDT_timeZone), "")
            }
            else
            {
                XCTFail("pubDate shouldn't be nil")
            }
            
            XCTAssert(myItem.itemDescription == " Many people have asked about the Balloons playground we demonstrated when introducing Swift at WWDC. Balloons shows that writing code can be interactive and fun, while presenting several great features of playgrounds. Now you can learn how the special effects were done with this tutorial version of ‘Balloons.playground’, which includes documentation and suggestions for experimentation.  This playground uses new features of SpriteKit and requires the latest beta versions of Xcode 6 and  OS X Yosemite . ", "")
            XCTAssert(myItem.content == "<p>Many people have asked about the Balloons playground we demonstrated when introducing Swift at WWDC. Balloons shows that writing code can be interactive and fun, while presenting several great features of playgrounds. Now you can learn how the special effects were done with this tutorial version of ‘Balloons.playground’, which includes documentation and suggestions for experimentation.</p><p>This playground uses new features of SpriteKit and requires the latest beta versions of Xcode 6 and <span class=\"nowrap\">OS X Yosemite</span>.</p>", "")
            
            myItem = items![7]
            
            XCTAssert(myItem.title == "Boolean", "")
            
            myItem = items![8]
            
            XCTAssert(myItem.title == "Files and Initialization", "")
            
            myItem = items![9]
            
            XCTAssert(myItem.title == "Interacting with C Pointers", "")
            
            myItem = items![10]
            
            XCTAssert(myItem.title == "Access Control", "")
            
            myItem = items![11]
            
            XCTAssert(myItem.title == "Building  assert()  in Swift, Part 1: Lazy Evaluation", "")
            
            myItem = items![12]
            
            XCTAssert(myItem.title == "Swift Language Changes in Xcode 6 beta 3", "")
            
            myItem = items![13]
            
            XCTAssert(myItem.title == "Compatibility", "")
            
            myItem = items![14]
            
            XCTAssert(myItem.title == "Welcome to Swift Blog", "")
            
            if let link = myItem.link?
            {
                XCTAssert(link.absoluteString == "http://developer.apple.com/swift/blog/?id=1", "")
            }
            else
            {
                XCTFail("link shouldn't be nil")
            }
            
            XCTAssert(myItem.guid == "http://developer.apple.com/swift/blog/?id=1", "")
            
            if let date = myItem.pubDate?
            {
                var dateComponent = self.calendar.components(self.calendar_flags, fromDate: date)
                
                XCTAssert(dateComponent.weekday == 6, "")
                XCTAssert(dateComponent.day == 11, "")
                XCTAssert(dateComponent.month == 7, "")
                XCTAssert(dateComponent.year == 2014, "")
                XCTAssert(dateComponent.hour == 10, "")
                XCTAssert(dateComponent.minute == 0, "")
                XCTAssert(dateComponent.second == 0, "")
                XCTAssert(dateComponent.timeZone!.isEqualToTimeZone(self.PDT_timeZone), "")
            }
            else
            {
                XCTFail("pubDate shouldn't be nil")
            }
            
            XCTAssert(myItem.itemDescription == " This new blog will bring you a behind-the-scenes look into the design of the Swift language by the engineers who created it, in addition to the latest news and hints to turn you into a productive Swift programmer.  Get started with Swift by downloading  Xcode 6 beta , now available to all Registered Apple Developers for free. The Swift Resources tab has a ton of great links to videos, documentation, books, and sample code to help you become one of the world’s first Swift experts. There’s never been a better time to get coding!  - The Swift Team  ", "")
            XCTAssert(myItem.content == "<p>This new blog will bring you a behind-the-scenes look into the design of the Swift language by the engineers who created it, in addition to the latest news and hints to turn you into a productive Swift programmer.</p><p>Get started with Swift by downloading <a href=\"http://developer.apple.com/devcenter/download.action?path=/Developer_Tools/xcode_6_beta_3_lpw27r/xcode_6_beta_3.dmg\" alt=\"\">Xcode 6 beta</a>, now available to all Registered Apple Developers for free. The Swift Resources tab has a ton of great links to videos, documentation, books, and sample code to help you become one of the world’s first Swift experts. There’s never been a better time to get coding!</p><p>- The Swift Team </p>", "")
            
        })
        
        waitForExpectationsWithTimeout(100, handler: { error in
            
        })
    }
    
    func test_parser_withWordpressMock_shouldReturnTheRightValues() {
        
        let request: NSURLRequest = NSURLRequest(URL: NSURL(fileURLWithPath: wordpressMockFileURL!))
        let expectation = self.expectationWithDescription("GET \(request.URL)")
        
        RSSParser.parseFeedForRequest(request, callback: { (feedMeta, items, error) -> Void in
            
            expectation.fulfill()
            
            self.calendar.timeZone = self.GMT_timeZone
            
            XCTAssertTrue(items!.count == 10, "should have 10 items")
            XCTAssertNil(error, "error should be nil")
            
            if let meta = feedMeta?
            {
                XCTAssert(meta.title == "WordPress.com News", "")
                if let link = meta.link?
                {
                    XCTAssert(link.absoluteString == "http://en.blog.wordpress.com", "")
                }
                XCTAssert(meta.feedDescription == "The latest news on WordPress.com and the WordPress community.", "")
                
                XCTAssert(meta.language == "en", "")
                
                if let date = meta.lastBuildDate?
                {
                    var dateComponent = self.calendar.components(self.calendar_flags, fromDate: date)
                    
                    XCTAssert(dateComponent.weekday == 6, "")
                    XCTAssert(dateComponent.day == 3, "")
                    XCTAssert(dateComponent.month == 10, "")
                    XCTAssert(dateComponent.year == 2014, "")
                    XCTAssert(dateComponent.hour == 13, "")
                    XCTAssert(dateComponent.minute == 49, "")
                    XCTAssert(dateComponent.second == 47, "")
                    XCTAssert(dateComponent.timeZone!.isEqualToTimeZone(self.GMT_timeZone), "")
                }
                else
                {
                    XCTFail("lastBuildDate shouldn't be nil")
                }
                
                XCTAssert(meta.generator == "http://wordpress.com/", "")
            }
            else
            {
                XCTFail("feed meta shouldn't be nil")
            }
            
            var myItem = items![1]
            
            XCTAssert(myItem.title == "Engaged, Inspired, and Ready to Build a Better Web", "")
            
            if let link = myItem.link?
            {
                XCTAssert(link.absoluteString == "http://en.blog.wordpress.com/2014/09/30/grand-meetup-reflections/", "")
            }
            else
            {
                XCTFail("link shouldn't be nil")
            }
            
            XCTAssert(myItem.guid == "http://en.blog.wordpress.com/?p=28737", "")
            
            if let date = myItem.pubDate?
            {
                var dateComponent = self.calendar.components(self.calendar_flags, fromDate: date)
                
                XCTAssert(dateComponent.weekday == 3, "")
                XCTAssert(dateComponent.day == 30, "")
                XCTAssert(dateComponent.month == 9, "")
                XCTAssert(dateComponent.year == 2014, "")
                XCTAssert(dateComponent.hour == 15, "")
                XCTAssert(dateComponent.minute == 0, "")
                XCTAssert(dateComponent.second == 0, "")
                XCTAssert(dateComponent.timeZone!.isEqualToTimeZone(self.GMT_timeZone), "")
            }
            else
            {
                XCTFail("pubDate shouldn't be nil")
            }
            
            XCTAssert(myItem.itemDescription == "One week every year, the entire <a href=\"http://automattic.com\">Automattic</a> staff gets together to connect, work, and laugh. And then, of course, we blog about it! Could you be blogging about your experience with us in 2015?<img alt=\"\" border=\"0\" src=\"http://pixel.wp.com/b.gif?host=en.blog.wordpress.com&#038;blog=3584907&#038;post=28737&#038;subd=en.blog&#038;ref=&#038;feed=1\" width=\"1\" height=\"1\" />", "")
//            XCTAssert(myItem.content == "", "")
            
             myItem = items![6]
            
            XCTAssert(myItem.title == "Gmail Password Leak Update", "")
            
            if let link = myItem.link?
            {
                XCTAssert(link.absoluteString == "http://en.blog.wordpress.com/2014/09/12/gmail-password-leak-update/", "")
            }
            else
            {
                XCTFail("link shouldn't be nil")
            }
            
            XCTAssert(myItem.guid == "http://en.blog.wordpress.com/?p=28615", "")
            
            if let date = myItem.pubDate?
            {
                var dateComponent = self.calendar.components(self.calendar_flags, fromDate: date)
                
                XCTAssert(dateComponent.weekday == 6, "")
                XCTAssert(dateComponent.day == 12, "")
                XCTAssert(dateComponent.month == 9, "")
                XCTAssert(dateComponent.year == 2014, "")
                XCTAssert(dateComponent.hour == 23, "")
                XCTAssert(dateComponent.minute == 53, "")
                XCTAssert(dateComponent.second == 37, "")
                XCTAssert(dateComponent.timeZone!.isEqualToTimeZone(self.GMT_timeZone), "")
            }
            else
            {
                XCTFail("pubDate shouldn't be nil")
            }
            
            XCTAssert(myItem.itemDescription == "We've taken extra steps to protect WordPress.com members.<img alt=\"\" border=\"0\" src=\"http://pixel.wp.com/b.gif?host=en.blog.wordpress.com&#038;blog=3584907&#038;post=28615&#038;subd=en.blog&#038;ref=&#038;feed=1\" width=\"1\" height=\"1\" />", "")
            XCTAssert(myItem.content == "<p>This week, a group of hackers <a title=\"Russian Hackers Released Gmail Password List\" href=\"http://time.com/3318853/google-user-logins-bitcoin/\">released a list</a> of about 5 million Gmail addresses and passwords. This list was not generated as a result of an exploit of WordPress.com, but since a number of emails on the list matched email addresses associated with WordPress.com accounts, we took steps to protect our users.</p>", "")
          
        })
        
        waitForExpectationsWithTimeout(100, handler: { error in
            
        })
        
    }
    
    func test_parser_withTumblrMock_shouldReturnTheRightValues() {
        
        let request: NSURLRequest = NSURLRequest(URL: NSURL(fileURLWithPath: tumblrMockFileURL!))
        let expectation = self.expectationWithDescription("GET \(request.URL)")
        
        RSSParser.parseFeedForRequest(request, callback: { (feedMeta, items, error) -> Void in
            
            expectation.fulfill()
            
            self.calendar.timeZone = self.DST_timeZone
            
            XCTAssertTrue(items!.count == 20, "should have 20 items")
            XCTAssertNil(error, "error should be nil")
            
            if let meta = feedMeta?
            {
                XCTAssert(meta.title == "Tumblr Engineering", "")
                if let link = meta.link?
                {
                    XCTAssert(link.absoluteString == "http://engineering.tumblr.com/", "")
                }
                XCTAssert(meta.feedDescription == "Dispatches from the intrepid tinkerers behind technology at Tumblr.", "")
                
                XCTAssert(meta.generator == "Tumblr (3.0; @engineering)", "")
            }
            else
            {
                XCTFail("feed meta shouldn't be nil")
            }
            
            var myItem = items![0]
            
            XCTAssert(myItem.title == "Sam Giddins: My Summer at TumblrThis summer, I had the immense...", "")
            
            if let link = myItem.link?
            {
                XCTAssert(link.absoluteString == "http://engineering.tumblr.com/post/98331642904", "")
            }
            else
            {
                XCTFail("link shouldn't be nil")
            }
            
            XCTAssert(myItem.guid == "http://engineering.tumblr.com/post/98331642904", "")
            
            if let date = myItem.pubDate?
            {
                var dateComponent = self.calendar.components(self.calendar_flags, fromDate: date)
                
                XCTAssert(dateComponent.weekday == 4, "")
                XCTAssert(dateComponent.day == 24, "")
                XCTAssert(dateComponent.month == 9, "")
                XCTAssert(dateComponent.year == 2014, "")
                XCTAssert(dateComponent.hour == 16, "")
                XCTAssert(dateComponent.minute == 43, "")
                XCTAssert(dateComponent.second == 45, "")
                XCTAssert(dateComponent.timeZone!.isEqualToTimeZone(self.DST_timeZone), "")
            }
            else
            {
                XCTFail("pubDate shouldn't be nil")
            }
            
            XCTAssert(myItem.itemDescription == "<img src=\"http://33.media.tumblr.com/fc576f290358def5f021b7a99032aa0c/tumblr_nc05ipn7h61qjk2rvo1_500.jpg\"/><br/><br/><h2><a href=\"http://blog.segiddins.me/\">Sam Giddins: My Summer at Tumblr</a></h2><div><p>This summer, I had the immense pleasure of working on the Tumblr iOS app. From day one, I got to work with an incredible team on an incredible app writing production code. Over the course of nearly 100 pull requests, I managed to get my hands on almost every piece of the app, from design changes to code refactors to some sweet new features.<br/><br/>The best part about the summer was working alongside multiple teams at Tumblr (iOS, Creative, API) making real, significant changes to one of the most polished apps on the App Store. When the summer started, I’d never written a custom animation, but after a few weeks I was helping to debug some of the fun things we do with CoreAnimation. Monday of my second week I found a bug in the API and got to spend a day looking through PHP code to help track that down. One Friday, I started work on some new things that will come out soon—at 5 pm, on a whim. By Monday, I was demoing the changes to Peter Vidani. That sort of rapid feedback is incredible, and really made my experience at Tumblr a joy—I got to make a real difference on the app.<br/><br/>In addition to the code I wrote (which was a lot!), I got to work with the team on all of the other facets of the app development lifecycle, from the existential frustration of dealing with translations to setting up a CI build server. I review several hundred pull requests, and spent hours discussing code with brilliant collegues who were never hesitant to debate the intricacies of what we were working on.<br/><br/>Throughout the summer, I was constantly in awe of the amazing work done at Tumblr every day. I’m proud to say that I got to contribute to the next few updates, and will forever cherish the experiences I had during my time at Tumblr HQ.<br/><br/></p></div>", "")
            
            myItem = items![1]
            
            XCTAssert(myItem.title == "Megan Belzner: My Summer at TumblrThis summer I got the amazing...", "")
            
            if let link = myItem.link?
            {
                XCTAssert(link.absoluteString == "http://engineering.tumblr.com/post/98050002584", "")
            }
            else
            {
                XCTFail("link shouldn't be nil")
            }
            
            XCTAssert(myItem.guid == "http://engineering.tumblr.com/post/98050002584", "")
            
            if let date = myItem.pubDate?
            {
                var dateComponent = self.calendar.components(self.calendar_flags, fromDate: date)
                
                XCTAssert(dateComponent.weekday == 1, "")
                XCTAssert(dateComponent.day == 21, "")
                XCTAssert(dateComponent.month == 9, "")
                XCTAssert(dateComponent.year == 2014, "")
                XCTAssert(dateComponent.hour == 8, "")
                XCTAssert(dateComponent.minute == 42, "")
                XCTAssert(dateComponent.second == 50, "")
                XCTAssert(dateComponent.timeZone!.isEqualToTimeZone(self.DST_timeZone), "")
            }
            else
            {
                XCTFail("pubDate shouldn't be nil")
            }
            
            XCTAssert(myItem.itemDescription == "<img src=\"http://33.media.tumblr.com/09552c5d09b7221d2409c3b42d046208/tumblr_nc05chwHhp1qjk2rvo1_500.jpg\"/><br/><br/><h2><a href=\"http://ivynewton.tumblr.com/\">Megan Belzner: My Summer at Tumblr</a></h2><p>This summer I got the amazing opportunity to intern as a product engineer on the Creation team. I didn’t really know what to expect when I first stepped in to the office, but whatever hopes and expectations I could have had, the summer far surpassed them.<br/><br/>The Creation team is in charge of one of the most important parts of the Tumblr site - posting tools - and most of my summer was spent working with the others on the team to overhaul the code underlying that part of the site. Coming in at the beginning of the summer, I could count the number of times I had worked in an existing codebase on one hand - namely: once, maybe twice. But with the help of the incredible Creation team, I dove right in and started contributing bug fixes, updates, and even entire features. Starting in the very first week I was already writing and deploying code, fixing a bug with note counts and updating Tumblr’s user engagement emails. By the end of the summer, I found myself getting ownership of pretty significant parts of the project. Even better, I had learned how to easily track down the source of a bug, figure out what this or that bit of code actually did, and navigate the figurative jungle of javascript.<br/><br/>It was incredibly exciting and rewarding to work on such a central part of the Tumblr site, knowing that people are going to be using some of the code I wrote to make millions of posts a day. I learned a tremendous amount about front-end web development, going from knowing a pretty minimal amount of javascript to knowing all sorts of intricacies about browser implementations and fluently speaking backbone.js and underscore.js.<br/><br/>Working at Tumblr really was a dream come true, and though I’m excited to get back to my friends at MIT, I’ve realized that this is absolutely something I could do for the rest of my life (or the foreseeable future, at least). Spending the day bringing ideas to life for Tumblr’s millions of users, surrounded by the most creative, smart, and friendly people I’ve ever met - It almost feels like cheating that I got to call that “work”.<br/><br/></p>", "")
            
        })
        
        waitForExpectationsWithTimeout(100, handler: { error in
            
        })
        
    }
    
    func test_parser_withInvalidMock_shouldReturnParsingError() {
        
        let request: NSURLRequest = NSURLRequest(URL: NSURL(fileURLWithPath: invalidMockFileURL!))
        let expectation = self.expectationWithDescription("GET \(request.URL)")
        
        RSSParser.parseFeedForRequest(request, callback: { (feedMeta, items, error) -> Void in
            
            expectation.fulfill()
            
            XCTAssertNotNil(error, "error shouldn't be nil")
            XCTAssert(error!.domain == "NSXMLParserErrorDomain")
        })
        
        waitForExpectationsWithTimeout(100, handler: { error in
            
        })
        
    }
    
    func test_parser_withInvalidURL_shouldReturnNetworkError() {
        
        let request: NSURLRequest = NSURLRequest(URL: NSURL(string: "file://no/no/no/nothing.rss"))
        let expectation = self.expectationWithDescription("GET \(request.URL)")
        
        RSSParser.parseFeedForRequest(request, callback: { (feedMeta, items, error) -> Void in
            
            expectation.fulfill()
            
            XCTAssertNotNil(error, "error shouldn't be nil")
            XCTAssert(error!.domain == "NSURLErrorDomain")
        })
        
        waitForExpectationsWithTimeout(100, handler: { error in
            
        })
        
    }
    
    func test_parser_withEmptyMock_shouldBehaveProperly() {
        
        let request: NSURLRequest = NSURLRequest(URL: NSURL(fileURLWithPath: emptyMockFileURL!))
        let expectation = self.expectationWithDescription("GET \(request.URL)")
        
        RSSParser.parseFeedForRequest(request, callback: { (feedMeta, items, error) -> Void in
            
            expectation.fulfill()
            
            XCTAssert((items!.count == 1), "number of items should be equal to 1")
            XCTAssertNil(error, "error should be nil")
        })
        
        waitForExpectationsWithTimeout(100, handler: { error in
            
        })
    }
    
}
