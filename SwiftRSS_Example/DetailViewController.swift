//
//  DetailViewController.swift
//  SwiftRSS_Example
//
//  Created by Thibaut LE LEVIER on 05/09/2014.
//  Copyright (c) 2014 Thibaut LE LEVIER. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
                            
    @IBOutlet weak var itemWebView: UIWebView!


    var detailItem: RSSItem? {
        didSet {
            self.configureView()
        }
    }

    func configureView() {
        
        if let item: RSSItem = self.detailItem
        {
            if let webView = self.itemWebView
            {
                let templateURLP = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("template", ofType: "html")!)

                let  templateURL : NSURL? = templateURLP

                if (templateURL != nil)
                {
                    var template = try! NSString(contentsOfURL: templateURL!, encoding: NSUTF8StringEncoding)

                        if let title = item.title
                        {
                            template = template.stringByReplacingOccurrencesOfString("###TITLE###", withString: title)
                        }
                        
                        if let content = item.content
                        {
                            template = template.stringByReplacingOccurrencesOfString("###CONTENT###", withString: content)
                        }
                        else if let description = item.itemDescription
                        {
                            template = template.stringByReplacingOccurrencesOfString("###CONTENT###", withString: description)
                        }
                        
                        if let date = item.pubDate
                        {
                            var formatter = NSDateFormatter()
                            formatter.dateFormat = "MMM dd, yyyy"
                            
                            template = template.stringByReplacingOccurrencesOfString("###DATE###", withString: formatter.stringFromDate(date))
                        }
                        
                        webView.loadHTMLString(template as String, baseURL: nil)

                    
                }
                else
                {
                    if let content = item.content
                    {
                        webView.loadHTMLString(content, baseURL: nil)
                    }
                    else if let description = item.itemDescription
                    {
                        webView.loadHTMLString(description, baseURL: nil)
                    }
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

